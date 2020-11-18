#################################################
# import dependencies 
from matplotlib import style
style.use('fivethirtyeight')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
from flask import Flask, jsonify
#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)
# Save references to each table
Measurement = Base.classes.measurement
Station = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################
@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"- List of prior year rain totals from all stations<br/>"
        f"<br/>"
        f"/api/v1.0/stations<br/>"
        f"- List of Station numbers and names<br/>"
        f"<br/>"
        f"/api/v1.0/tobs<br/>"
        f"- List of prior year temperatures from the most active station<br/>"
        f"<br/>"
        f"/api/v1.0/start<br/>"
        f"- Put start date (YYYY-MM-DD), calculates the MIN/AVG/MAX temperature for all dates greater than and equal to the start date<br/>"
        f"<br/>"
        f"/api/v1.0/start/end<br/>"
        f"- Put start and the end date (YYYY-MM-DD), calculate the MIN/AVG/MAX temperature for dates between the start and end date inclusive<br/>"

    )
#########################################################################################

@app.route("/api/v1.0/precipitation")
def precipitation():
    print("Server received request for 'precipitation' page...")
# Convert the query results to a dictionary using date as the key and prcp as the value
    one_year_ago = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    data = session.query(Measurement.date, Measurement.prcp).\
        filter(Measurement.date > one_year_ago).\
        order_by(Measurement.date).all()
    
# Return the JSON representation of your dictionary.
    data_list = []
    for row in data:
        append_data = {}
        append_data["date"] = row[0]
        append_data["prcp"] = row[1]
        data_list.append(append_data)
    return jsonify(data_list)

#########################################################################################
@app.route("/api/v1.0/stations")

# Return a JSON list of stations from the dataset.
def stations():
    print("Server received request for 'stations' page...")
    stations_query = session.query(Station.name, Station.station)
    stations = pd.read_sql(stations_query.statement, stations_query.session.bind)
    return jsonify(stations.to_dict())
#########################################################################################
@app.route("/api/v1.0/tobs")
def tobs():
    print("Server received request for 'tobs' page...")
# Query the dates and temperature observations of the most active station for the last year of data.
    most_active_stations = session.query(Measurement.station, func.count(Measurement.tobs)).group_by(Measurement.station).order_by(func.count(Measurement.tobs).desc()).all()
    most_active = most_active_stations[0][0]

    one_year_ago = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    temp_data = session.query(Measurement.station,Measurement.date, Measurement.tobs).\
        filter(Measurement.date > one_year_ago).\
        filter(Measurement.station == most_active).\
        order_by(Measurement.date).all()

# Return a JSON list of temperature observations (TOBS) for the previous year.
    temperature_list = []
    for row in temp_data:
        append_temp_data = {}
        append_temp_data["date"] = row[1]
        append_temp_data["tobs"] = row[2]
        temperature_list.append(append_temp_data)

    return jsonify(temperature_list)
#########################################################################################
@app.route("/api/v1.0/<start>")
def trip1(start):

# Return a JSON list of the minimum temperature, the average temperature, and the max temperature for a given start or range   
    start_date= dt.datetime.strptime(start, '%Y-%m-%d')
    last_year = dt.timedelta(days=365)
    start = start_date
    end =  dt.date(2017, 8, 23)
    trip_data = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start).filter(Measurement.date <= end).all()
    trip = {}
    trip['lowest_temp'] = trip_data[0][0]
    trip['average_temp'] = round(trip_data[0][1],0)
    trip['highest_temp'] = trip_data[0][2]
    return jsonify(trip)
    

#########################################################################################
@app.route("/api/v1.0/<start>/<end>")
def trip2(start,end):

# Return a JSON list of the minimum temperature, the average temperature, and the max temperature for a start-end    rangep     
    start_date_1= dt.datetime.strptime(start, '%Y-%m-%d')
    end_date_1= dt.datetime.strptime(end,'%Y-%m-%d')
    start_1 = start_date_1
    end_1 = end_date_1
    trip_data_1 = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start_1).filter(Measurement.date <= end_1).all()
    trip_1 = {}
    trip_1['lowest_temp'] = trip_data_1[0][0]
    trip_1['average_temp'] = round(trip_data_1[0][1],0)
    trip_1['highest_temp'] = trip_data_1[0][2]
    return jsonify(trip_1)

#########################################################################################

if __name__ == "__main__":
    app.run(debug=True)