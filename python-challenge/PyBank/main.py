import os
import csv

csvpath = os.path.join("../../","PyBank/Resources/","budget_data.csv")

with open(csvpath) as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ",")
    header = next(csvreader)
    Date = []
    Amount=[]
    for row in csvreader:
        Date.append(row[0])
        Amount.append(int(row[1])) 
    
    Total_months = len(Date)
    Total_amounts = sum(Amount)
    Avg_Change = Total_amounts/Total_months
    Greatest_Increase_amount = max(Amount)
    Greatest_Decrease_amount = min(Amount)

    print("Financial Analysis")
    print("-------------------------------")
    print(f"Total Months: {str(Total_months)}")
    print(f"Total: ${Total_amounts}")
    print(f"Average  Change: ${str(round(Avg_Change,2))}")
with open(csvpath) as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ",")
    header = next(csvreader)
    for row in csvreader:
        if int(row[1]) == Greatest_Increase_amount:

            print("Greatest Increase in Profits: " +row[0]+" ($"+row[1]+")")
        if int(row[1]) == Greatest_Decrease_amount:
            print("Greatest Decrease in Profits: " +row[0]+" ($"+row[1]+")")    
           
    



