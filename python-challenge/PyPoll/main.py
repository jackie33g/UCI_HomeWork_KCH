import os
import csv

csvpath = os.path.join("../../","PyPoll/Resources/","election_data.csv")


with open(csvpath) as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ",")
    header = next(csvreader)
    Voter= []
    Candidate= []
    unique_Candidate=[]
    Vote_1=[]
    Vote_2=[]
    Vote_3=[]
    Vote_4=[]
    for row in csvreader:
        Voter.append(row[0])
        Candidate.append(row[2])

        if row[2] not in unique_Candidate:
            unique_Candidate.append(row[2]) 
        if row[2] == unique_Candidate[0]:
            Vote_1.append(row[0])
        elif row[2] == unique_Candidate[1]:
            Vote_2.append(row[0])
        elif row[2] == unique_Candidate[2]:
            Vote_3.append(row[0])
        elif row[2] == unique_Candidate[3]:
            Vote_4.append(row[0])

    Total_votes= len(Voter)

    Total_vote_1=len(Vote_1)
    Percent_vote_1=round((Total_vote_1/Total_votes)*100,3)

    Total_vote_2=len(Vote_2)
    Percent_vote_2=round((Total_vote_2/Total_votes)*100,3)

    Total_vote_3=len(Vote_3)
    Percent_vote_3=round((Total_vote_3/Total_votes)*100,3)

    Total_vote_4=len(Vote_4)
    Percent_vote_4=round((Total_vote_4/Total_votes)*100,3)
    result={"name":[unique_Candidate[0],
                    unique_Candidate[1],
                    unique_Candidate[2],
                    unique_Candidate[3]],
            "voted":[Total_vote_1,
                     Total_vote_2,
                     Total_vote_3,
                     Total_vote_4]
                     }

    test=max(result["voted"])
    winner=[]
    if result["voted"][0]==test:
        winner.append(result["name"][0])
    if result["voted"][1]==test:
        winner.append(result["name"][1])
    if result["voted"][2]==test:
        winner.append(result["name"][2])
    if result["voted"][3]==test:
        winner.append(result["name"][3])

    print("Election Results")
    print("-------------------------------")
    print(f"Total Votes: {str(Total_votes)}")
    print("-------------------------------")
    print(f"{unique_Candidate[0]}: {Percent_vote_1}% ({Total_vote_1})")
    print(f"{unique_Candidate[1]}: {Percent_vote_2}% ({Total_vote_2})")
    print(f"{unique_Candidate[2]}: {Percent_vote_3}% ({Total_vote_3})")
    print(f"{unique_Candidate[3]}: {Percent_vote_4}% ({Total_vote_4})")
    print("-------------------------------")
    print(f"Winner: {winner}")
    print("-------------------------------")


   
   