Sub StockSummarize():

    'loop for each single worksheet.
    Dim Sh As Integer
    
    ' From the first sheet to the count of worksheet.
      For Sh = 1 To Worksheets.Count
      
            'Out put the log box to check which sheet the loop is working at.
            MsgBox ("Loop is working in the Sheet " + Str(Sh))
            
                            'Define the variables and initialize the variable.
                            Dim Check, Count, Unique As Integer
                                Check = 0
                                Count = 0
                                Unique = 0
                            'Define the variables and initialize the variable.
                            Dim Op, Cl, Vol As Double
                                Vol = 0
                                
                            'Define the variables for count the row A and row I.
                            Dim ARow As Long
                            Dim IRow As Long
                            
                            'Count how many rows in A and I.
                            ARow = Worksheets(Sh).Cells(Rows.Count, 1).End(xlUp).Row
                            IRow = Worksheets(Sh).Cells(Rows.Count, 9).End(xlUp).Row
                            
                            'Fill the header.
                            Worksheets(Sh).Range("I1").Value = "Ticker"
                            Worksheets(Sh).Range("J1").Value = "Yearly Change"
                            Worksheets(Sh).Range("K1").Value = "Percent Change"
                            Worksheets(Sh).Range("L1").Value = "Total Stock Volume"
                            Worksheets(Sh).Range("O2").Value = "Greatest % Increase"
                            Worksheets(Sh).Range("O3").Value = "Greatest % Decrease"
                            Worksheets(Sh).Range("O4").Value = "Greatest Total Volume"
                            
                                    'Loop from A2 to the end of A.
                                    For I = 2 To ARow
                                        
                                        'Determine if the Ticker is the unique one
                                        If Worksheets(Sh).Cells(I + 1, 1).Value <> Worksheets(Sh).Cells(I, 1).Value Then
                                        
                                            'Mark the last count of the symbol is 1 and mark the symbol as the number for auto fill the symbol to Col I.
                                            Unique = 1
                                            Check = Check + 1
                                            
                                            'When the mark is 1, set the close amont as the close price of the year.
                                            Cl = Worksheets(Sh).Cells(I, 6).Value
                                            
                                            'When the Count = 0, that row will be the last data of the symbol.
                                            Count = 0
                                        Else
                                            'If the ticker is not the unique one.
                                            'Calculate the Volume of the Ticker
                                            Vol = Vol + Worksheets(Sh).Cells(I, 7).Value
                                            
                                            'Count the first data of the symbol.
                                            Count = Count + 1
                                            'Set variable a to determine which row is the first data of the symbol.
                                            a = I - Count + 1
                                            
                                            'Output the number for debug
                                            'Worksheets(Sh).Cells(i, 15).Value = a
                                            
                                            'Set the Opening price
                                            Op = Worksheets(Sh).Cells(a, 3).Value
                                            
                                            'Initialize the mark
                                            Unique = 0
                                        End If
                                        
                                        'Check the mark number and set the current symbol is the unique one and output the results one by one to Col I by the mark Check.
                                        If Unique = 1 Then
                                            
                                            Worksheets(Sh).Cells(Check + 1, 9).Value = Worksheets(Sh).Cells(I, 1).Value
                                            
                                            'Calculate the total Vol and plus the volume of the first data
                                            Worksheets(Sh).Cells(Check + 1, 12).Value = Vol + Worksheets(Sh).Cells(I, 7).Value
                                            
                                            'Calculate the difference price from the opening to closing
                                            Worksheets(Sh).Cells(Check + 1, 10).Value = Cl - Op
                                            
                                            'Formating the data
                                            Worksheets(Sh).Cells(Check + 1, 10).NumberFormatLocal = "$#,##0.00"
                                
                                            'Output the number for debug
                                            'Cells(Check + 1, 13).Value = Op
                                            'Cells(Check + 1, 14).Value = Cl
                                            
                                            'Exclude the error when the opening price is 0
                                            If Op <> 0 Then
                                            
                                                Worksheets(Sh).Cells(Check + 1, 11).Value = Worksheets(Sh).Cells(Check + 1, 10).Value / Op
                                                Worksheets(Sh).Cells(Check + 1, 11).NumberFormatLocal = "0.00%"
                                            
                                            Else
                                                Worksheets(Sh).Cells(Check + 1, 11).Value = Cells(Check + 1, 10).Value / 1
                                                Worksheets(Sh).Cells(Check + 1, 11).NumberFormatLocal = "0.00%"
                                             
                                            End If
                                             
                                            'Formating the color of cells by the condition.
                                            If Worksheets(Sh).Cells(Check + 1, 11).Value < 0 Then
                                                
                                                Worksheets(Sh).Cells(Check + 1, 11).Interior.ColorIndex = 3
                                                    
                                            Else
                                                
                                                Worksheets(Sh).Cells(Check + 1, 11).Interior.ColorIndex = 4
                                                    
                                            End If
                                                
                                                'Initialize the variable
                                                Vol = 0
                                        
                                                    'Use the sort to determine the greatest amount of Increase, Decrease and the Total Volume and the symbol.
                                                    If Greatest_Increase < Worksheets(Sh).Cells(Check + 1, 11).Value Then
                                                    
                                                        Greatest_Increase = Worksheets(Sh).Cells(Check + 1, 11).Value
                                                        GI_Ticker_Number = Worksheets(Sh).Cells(Check + 1, 9).Value
                                                        
                                                    Else
                                                    
                                                        Greatest_Increase = Greatest_Increase
                                                        
                                                    End If
                                                    
                                                    If Greatest_Decrease > Worksheets(Sh).Cells(Check + 1, 11).Value Then
                                                    
                                                        Greatest_Decrease = Worksheets(Sh).Cells(Check + 1, 11).Value
                                                        GD_Ticker_Number = Worksheets(Sh).Cells(Check + 1, 9).Value
                                                        
                                                    Else
                                                    
                                                        Greatest_Decrease = Greatest_Decrease
                                                        
                                                    End If
                                                    
                                                    If Greatest_Total_Vol < Worksheets(Sh).Cells(Check + 1, 12).Value Then
                                                    
                                                        Greatest_Total_Vol = Worksheets(Sh).Cells(Check + 1, 12).Value
                                                        GTV_Ticker_Number = Worksheets(Sh).Cells(Check + 1, 9).Value
                                                        
                                                    Else
                                                    
                                                        Greatest_Total_Vol = Greatest_Total_Vol
                                                        
                                                    End If
                                            
                                        End If
                                    
                                    Next I
                                        'Output the results to the Colunm P,Q
                                        
                                        Worksheets(Sh).Range("P1").Value = "Ticker"
                                        Worksheets(Sh).Range("P2").Value = GI_Ticker_Number
                                        Worksheets(Sh).Range("P3").Value = GD_Ticker_Number
                                        Worksheets(Sh).Range("P4").Value = GTV_Ticker_Number
                                        
                                        Worksheets(Sh).Range("Q1").Value = "Value"
                                        Worksheets(Sh).Range("Q2").Value = Greatest_Increase
                                        Worksheets(Sh).Range("Q2").NumberFormatLocal = "0.00%"
                                        Worksheets(Sh).Range("Q3").Value = Greatest_Decrease
                                        Worksheets(Sh).Range("Q3").NumberFormatLocal = "0.00%"
                                        Worksheets(Sh).Range("Q4").Value = Greatest_Total_Vol
                                        
                                        
                                        'Initialize the variable for the next sheet use
                                        Greatest_Increase = 0
                                        Greatest_Decrease = 0
                                        Greatest_Total_Vol = 0
Next

'Loop log
MsgBox ("Loop end! ")

End Sub

