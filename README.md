# Alicat-MATLAB

Simple control [Alicat](https://www.alicat.com/) mass flow controllers (MFCs) via MATLAB.



### Usage

First hard-code the correct COM port into `connectAlicat` then connect:


```
pollMFC('A',1,1)

ans = 

                ID: 'A'
          pressure: 15.0400
              temp: 32.2900
    volumetricFlow: 0.9000
          massFlow: 0.8990
          setPoint: 0.9000
               gas: 'Air'
              time: 7.3570e+005
```

### Other tools
[numat/alicat](https://github.com/numat/alicat) is a Python tool. 
