// Belly Button Biodiversity by Elvis Selimaj, GWU BootCamp 

// Function to pull names from json file and add them in the filter

var drawChart = function(xData, yData, hoverText, metadata) {


    var metadata_panel = d3.select("#sample-metadata");
    metadata_panel.html("");
    Object.entries(metadata).forEach(([key, value]) => {
        metadata_panel.append("p").text(`${key}: ${value}`);
    });
  

     var bar_data =[
      {
        y:xData.slice(0, 10).map(otuID => `OTU ${otuID}`).reverse(),
        x:yData.slice(0,10).reverse(),
        text:hoverText.slice(0,10).reverse(),
        type:"bar",
        orientation:"h"

      }
    ];

    var barLayout = {
      title: "Top 10 Bacteria Cultures Found",
      margin: { t: 30, l: 150 }
    };

    Plotly.newPlot("bar", bar_data, barLayout);
  
    var trace2 = {
        x: xData,
        y: yData,
        text: hoverText,
        mode: 'markers',
        marker: {
            size: yData,
            color: xData
        }
    };
  
    var data2 = [trace2];
  
    Plotly.newPlot('bubble', data2);
  
  
  };
  
  var populateDropdown = function(names) {
  
    var selectTag = d3.select("#selDataset");
    var options = selectTag.selectAll('option').data(names);
  
    options.enter()
        .append('option')
        .attr('value', function(d) {
            return d;
        })
        .text(function(d) {
            return d;
        });
  
  };
  
  var optionChanged = function(newValue) {
  
    d3.json("data/samples.json").then(function(data) {
  
    sample_new = data["samples"].filter(function(sample) {
  
        return sample.id == newValue;
  
    });
    
    metadata_new = data["metadata"].filter(function(metadata) {
  
        return metadata.id == newValue;
  
    });
    
    
    xData = sample_new[0]["otu_ids"];
    yData = sample_new[0]["sample_values"];
    hoverText = sample_new[0]["otu_labels"];
    
    
    drawChart(xData, yData, hoverText, metadata_new[0]);
    });
  };
  
  d3.json("data/samples.json").then(function(data) {
  
    //Populate dropdown with names
    populateDropdown(data["names"]);
  
    //Populate the page with the first value
    xData = data["samples"][0]["otu_ids"];
    yData = data["samples"][0]["sample_values"];
    hoverText = data["samples"][0]["otu_labels"];
    metadata = data["metadata"][0];
    datawfreq = data["metadata"][8];
  
    //Draw the chart on load
    drawChart(xData, yData, hoverText, metadata);
  });