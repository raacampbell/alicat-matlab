Control Alicat MFCs via MATLAB



Usage:

make serial connection with connectAlicat. Use handle as input argument to other functions. Remember to supply the correct COM port as an argument to connectAlicat or hard-code your COM port into that file. 


To do:
Make connection happen automatically. 


Example:

>> AC=connectAlicat;
>> pollMFC(AC,'A',1,1)

ans = 

                ID: 'A'
          pressure: 15.0400
              temp: 32.2900
    volumetricFlow: 0.9000
          massFlow: 0.8990
          setPoint: 0.9000
               gas: 'Air'
              time: 7.3570e+005
