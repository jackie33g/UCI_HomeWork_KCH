Sub test():

Dim Sh As Integer

           For Sh = 1 To Worksheets.Count
            MsgBox ("Loop is working in the Sheet " + Str(Sh))
                            Dim Check As Integer
                                Check = 0
                            Dim Vol As Double
                                Vol = 0
                            Dim Op As Double
                            Dim Cl As Double
                            Dim Count As Integer
                            
                            Dim ARow As Long
                            Dim IRow As Long
                            
                            ARow = Worksheets(Sh).Cells(Rows.Count, 1).End(xlUp).Row
                            IRow = Worksheets(Sh).Cells(Rows.Count, 9).End(xlUp).Row
                            
                

                            
                            Worksheets(Sh).Range("I1").Value = "Ticker"
                            Worksheets(Sh).Range("J1").Value = "Yearly Change"
                            Worksheets(Sh).Range("K1").Value = "Percent Change"
                            Worksheets(Sh).Range("L1").Value = "Total Stock Volume"
                            Worksheets(Sh).Range("O2").Value = "Greatest % Increase"
                            Worksheets(Sh).Range("O3").Value = "Greatest % Decrease"
                            Worksheets(Sh).Range("O4").Value = "Greatest Total Volume"
                            
                                    For I = 2 To ARow
                                        
                                        If Worksheets(Sh).Cells(I + 1, 1).Value <> Worksheets(Sh).Cells(I, 1).Value Then
                                        
                                            Worksheets(Sh).Cells(I, 8).Value = 1
                                            Check = Check + 1
                                            
                                            Cl = Worksheets(Sh).Cells(I, 6).Value
                                            Count = 0
                                        Else
                                            
                                            Vol = Vol + Worksheets(Sh).Cells(I, 7).Value
                                            Count = Count + 1
                                            a = I - Count + 1
                                            'Cells(i, 15).Value = A
                                            Op = Worksheets(Sh).Cells(a, 3).Value
                                        End If
                                        
                                         
                                        If Worksheets(Sh).Cells(I, 8) = 1 Then
                                            
                                            Worksheets(Sh).Cells(Check + 1, 9).Value = Worksheets(Sh).Cells(I, 1).Value
                                            Worksheets(Sh).Cells(Check + 1, 12).Value = Vol + Worksheets(Sh).Cells(I, 7).Value
                                            Worksheets(Sh).Cells(Check + 1, 10).Value = Cl - Op
                                            Worksheets(Sh).Cells(Check + 1, 10).NumberFormatLocal = "$#,##0.00"
                                            Worksheets(Sh).Cells(Check + 1, 11).NumberFormatLocal = "0.00%"
                                            
                                            'Cells(Check + 1, 13).Value = Op
                                            'Cells(Check + 1, 14).Value = Cl
                                            If Op <> 0 Then
                                            
                                            Worksheets(Sh).Cells(Check + 1, 11).Value = Worksheets(Sh).Cells(Check + 1, 10).Value / Op
                                            Worksheets(Sh).Cells(Check + 1, 11).NumberFormatLocal = "0.00%"
                                             Else
                                             Worksheets(Sh).Cells(Check + 1, 11).Value = Cells(Check + 1, 10).Value / 1
                                             Worksheets(Sh).Cells(Check + 1, 11).NumberFormatLocal = "0.00%"
                                             End If
                                             
                                                If Worksheets(Sh).Cells(Check + 1, 11).Value < 0 Then
                                                
                                                    Worksheets(Sh).Cells(Check + 1, 11).Interior.ColorIndex = 3
                                                    
                                                Else
                                                
                                                    Worksheets(Sh).Cells(Check + 1, 11).Interior.ColorIndex = 4
                                                    
                                                End If
                                                
                                                Vol = 0
                                                
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
                                        
                                        Worksheets(Sh).Range("H:H") = ""
                                        
                                        Greatest_Increase = 0
                                        Greatest_Decrease = 0
                                        Greatest_Total_Vol = 0
Next
End Sub
