from splinter import Browser
from bs4 import BeautifulSoup
import pandas as pd
import requests
import pymongo
from flask import Flask, render_template, redirect
from flask_pymongo import PyMongo
from webdriver_manager.chrome import ChromeDriverManager

def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {'executable_path': ChromeDriverManager().install()}
    return Browser("chrome", **executable_path, headless=False)

def scrape():
    browser = init_browser()
    mars_dict ={}

    #NASA_News_url
    NASA_News_url = "https://mars.nasa.gov/news"
    browser.visit(NASA_News_url)

    html = browser.html
    NASA_soup = BeautifulSoup(html, "html.parser")

    slides = NASA_soup.find_all('li', class_='slide')
    content_title = slides[0].find('div', class_='content_title')
    news_title = content_title.text.strip()
    news_p = NASA_soup.find_all('div', class_='article_teaser_body')[0].text.strip()

    print(news_title)
    print("--------------------------------------------------------------------")
    print(news_p)

    #JPL Mars Space Images - Featured Image
    base_JPL_url = 'https://www.jpl.nasa.gov'
    image_url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'


    browser.visit(image_url)
    html = browser.html
    images_soup = BeautifulSoup(html, "html.parser")
    
    image_path = images_soup.find('article')['style'].replace('background-image: url(','').replace(');', '')[1:-1]
    featured_image_url = base_JPL_url + image_path


    #Mars Facts
    Mars_Facts_url = 'https://space-facts.com/mars/'
    tables = pd.read_html(Mars_Facts_url)
    facts_df = tables[0]
    facts_df.columns = ['Fact', 'Value']
    facts_df['Fact'] = facts_df['Fact'].str.replace(':', '')
    facts_html = facts_df.to_html()
    facts_df.to_html('marsfacts.html') # to save to a file to test
    # mars_html_table = mars_facts_df.to_html()
    # mars_html_table.replace('\n', '')
    

    #Mars Hemispheres
    base_Mars_Hemispheres_url = 'https://astrogeology.usgs.gov'
    Mars_Hemispheres_url = base_Mars_Hemispheres_url + '/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    
    browser.visit(Mars_Hemispheres_url)
    html = browser.html
    Hemispheres_soup = BeautifulSoup(html, 'html.parser')

    items = Hemispheres_soup.find_all('div', class_='item')
    image_urls = []

    titles = []
    for item in items:
        image_urls.append(base_Mars_Hemispheres_url + item.find('a')['href'])
        titles.append(item.find('h3').text.strip())

    img_urls = []
    for target in image_urls:
        browser.visit(target)
        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        target = base_Mars_Hemispheres_url+soup.find('img',class_='wide-image')['src']
        img_urls.append(target)


    hemisphere_image =[]
    for i in range(len(titles)):
        hemisphere_image.append({'title':titles[i],'img_url':img_urls[i]})

    # Close the browser after scraping
    browser.quit()

    mars_dict = {
        "news_title": news_title,
        "news_p": news_p,
        "featured_image_url": featured_image_url,
        "fact_table": facts_html,
        "hemisphere_images": hemisphere_image
    }

    # Return results
    return mars_dict
