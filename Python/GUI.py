######################### DISPLAY.PY ###############################

# Description: Program displays data sent from TBD to GUI 
#             using tkinter library
#
# Inputs:
#
# Author: Ben Capeloto
#Original use: ASEN 4018 Senior Projects DROPS team GUI Display
# Last edited by: Ben Capeloto
#Last edited date: 3/21/2022

                ###### Version History ##########
# V1.1 - 10/30/2021 - Display.py created, very basic functionality
# V2.1 - 1/22/2022 - This is what I am running now instead of GUI.py
#V2.2 - 2/4/2022 - Integrated ConnectXbee into display
#V3.1 - 2/21/2022 - Fixed boot, 4 latches, two way serial
#V3.2 - 3/21/2022 - Cleaned up code, robust commenting

###################################################################


############ Import libraries ###################
import tkinter as tk
from tkinter import simpledialog, messagebox
from digi.xbee.devices import *
import os
import datetime as datetime
import time as time 
import random
import matplotlib as plt
plt.use("TkAgg")
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg



################## FUNCTIONS #################### 
   

############## latchCommand ##################
# Description: function to send latch command to remote XBee
# Arguments: None
# Returns: None 
def latchCommand():
    # Send Data Asynchronously
    now = time.time()
    homeXbee.send_data_async(remoteXbee, "L") #String L for latch
    print("Latch Command Sent \n")



############## UNlatchCommand ################
# Description: function to send unlatch command to remote XBee
# Arguments: None
# Returns: None 
def unlatchCommand():
    # Send Data Asynchronously
    now = time.time()
    homeXbee.send_data_async(remoteXbee, "U") #String U for unlatch
    print("Unlatch Command Sent \n")


################ getData ###################
# Description: function to take data recieved from radio and turn it
#               into readable data to be displayed
# Arguments: optional input data in the form of a byte array with default set to 'None'
# Returns: clean data ready to be displayed on GUI
def getData(dataIn=None):
    
    ## Get current date and time for testing
    now = datetime.datetime.now()
    current_time = now.strftime("%H:%M:%S")
    #Check if data was recieved
    if dataIn is None:
        cleanData = {'Voltage': "...", 'Power': "...", 'Cargo': "...", 'Latch': "...", \
            'Latitude': "...", 'Longitude': "...", 'Latch 1': "...", 'Latch 2': "...",
            'Latch 3': "...", 'Latch 4': "...", 'TimeStamp': current_time}
    else: 
        L = dataIn.data.decode() 
        decoded = decodeData(L) #if data was recieved decode it
        #create clean data dict
        cleanData = {'Voltage': 45, 'Power': 'yes', 'Cargo': "full", 'Latch': decoded[5], \
            'Latitude': "40.0150° N", 'Longitude': "105.2705° W", 'Latch 1': decoded[0], 'Latch 2': decoded[1],
            'Latch 3': decoded[2], 'Latch 4': decoded[3], 'TimeStamp': current_time}
    return cleanData

############### decodeData ################
# Description: decodes Latch data recieved from Xbee
#              Latches: "1" : Locked
#                       "0" : Unlocked
#                       "E" : Lock Error
#                       "W" : Unlock Error
# Arguments: None
# Returns: None
def decodeData(data):
    decode = [[] for i in range(5)] #create empty array of decoded info

    # Data in is 4 bit for each of 4 latchs ex "0000", "0100", etc.
    if data[0] == "1":
        decode[0] = "1"
    elif data[0] == "0":
        decode[0] = "0"
    elif data[0] == "E":
        decode[0] = "L Err"
    elif data[0] == "W":
        decode[0] = "U Err"
    else:
        decode[0] = "Sys Err"

    if data[1] == "1":
        decode[1] = "1"
    elif data[1] == "0":
        decode[1] = "0"
    elif data[1] == "E":
        decode[1] = "L Err"
    elif data[1] == "W":
        decode[1] = "U Err"
    else:
        decode[1] = "Sys Err"
    
    if data[2] == "1":
        decode[2] = "1"
    elif data[2] == "0":
        decode[2] = "0"
    elif data[2] == "E":
        decode[2] = "L Err"
    elif data[2] == "W":
        decode[2] = "U Err"
    else:
        decode[2] = "Sys Err"
    
    if data[3] == "1":
        decode[3] = "1"
    elif data[3] == "0":
        decode[3] = "0"
    elif data[3] == "E":
        decode[3] = "L Err"
    elif data[3] == "W":
        decode[3] = "U Err"
    else:
        decode[3] = "Sys Err"
    decode[5] = data.count('1')
    return decode

############### updataData ################
# Description: function to read in data from radio then clean the data
#               and display it on the GUI
# Arguments: None
# Returns: None
def updateData():
    try: #try to get data from radio
        ## Recieve Data from XBee ##
        readData = homeXbee.read_data_from(remoteXbee, 0) #get data from remote XBee device
        remote = readData.remote_device 
        dataIn = readData.data #Pull data from API Frame
        is_broadcast = readData.is_broadcast
        timestamp = readData.timestamp #Get a timestamp on the data sent
        data = getData(readData) #Send data to the decoding and displaying functions
      
        #display data to GUI
        Timestamp['text'] = data['TimeStamp'] 
        
        BattVolt['text'] = str(data['Voltage'])
        PowStat['text'] = data['Power']
        CargoStat['text'] = data['Cargo']

        numLatch = data['Latch'].count('L')
        LatchStat['text'] = str(numLatch) + "/4"
    

        ## Latches

        Latch1['text'] = "Latch 1: " + data['Latch 1']
        Latch2['text'] = "Latch 2: " + data['Latch 2']
        Latch3['text'] = "Latch 3: " + data['Latch 3']
        Latch4['text'] = "Latch 4: " + data['Latch 4']

        #Change display color based on latch status
        if data['Latch 1'] == "1":
            Latch1['bg'] = latchFull
        elif data['Latch 1'] == "0":
            Latch1['bg'] = latchOpen
        else:
            Latch1['bg'] = latchDoor

        if data['Latch 2'] == "1":
            Latch2['bg'] = latchFull
        elif data['Latch 2'] == "0":
            Latch2['bg'] = latchOpen
        else:
            Latch2['bg'] = latchDoor

        if data['Latch 3'] == "1":
            Latch3['bg'] = latchFull
        elif data['Latch 3'] == "0":
            Latch3['bg'] = latchOpen
        else:
            Latch3['bg'] = latchDoor

        if data['Latch 4'] == "1":
            Latch4['bg'] = latchFull
        elif data['Latch 4'] == "0":
            Latch4['bg'] = latchOpen
        else:
            Latch4['bg'] = latchDoor
    
    except TimeoutException: #if radio does not send data no need to update GUI

        data = getData() 
        Timestamp['text'] = data['TimeStamp']
    #refresh the GUI window
    window.after(100, updateData)

############### startData ###############
# Description: function to fill GUI with blank data upon startup
# Arguments: None
# Returns: None
def startData():
        Timestamp['text'] = "..."  
        BattVolt['text'] = "..."
        PowStat['text'] = "..."
        CargoStat['text'] = "..."
        LatchStat['text'] = "..."

        ## Latches
        Latch1['text'] = "..."
        Latch2['text'] = "..."
        Latch3['text'] = "..."
        Latch4['text'] = "..."
        Latch1['bg'] = latchDoor
        Latch2['bg'] = latchDoor
        Latch3['bg'] = latchDoor
        Latch4['bg'] = latchDoor


############### windowParameters ###############
# Description: function to set all the window parameters as global
#               has no real purpose besides keeping main tidy
# Arguments: None
# Returns: None
def windowParameters():

    #Make them usable in all functions
    global winLength, winHeight, windowBGColor, geoString, startHeight, battFull, labelColorText
    global labelColorValue, buttonBackgroundA, buttonBackgroundP, battBar, battBack, latchFull
    global latchDoor, latchOpen, unlatchButtonA, unlatchButtonP
    ## Set screen size and color
    winLength = 1000
    winHeight = 600
    windowBGColor = '#15325B'

    ## Define Geometry and time
    geoString = str(winLength)+"x"+str(winHeight)
    startHeight = winHeight/6

    ## Battery full voltage
    battFull = 49.5 ## Full battery voltage must be define (using MaxAmps batts)

    ## Colors
    labelColorText = "#bad5f7" #Text label color hardcoded
    labelColorValue = "#9daec4" #Value label color hardcoded
    buttonBackgroundP =  "#c27272" #Passive background button color
    buttonBackgroundA = "#c72020" #Active background button color
    battBar = "#049138" #Battery bar fill color
    battBack = "#e4f0e8" #battery bar background color
    latchFull = "#89f594" # Latch is Full
    latchDoor = "#f7d26d" # Latch is door
    latchOpen =  "#f28d8d" # Latch is open
    unlatchButtonP = "#508404"
    unlatchButtonA = "#6DAC10"

def xBeeParameters():
    com = tk.Tk() #create start up window
    com.withdraw()
    # the input dialog
    comAddress = simpledialog.askstring(title="Radio Port",
                                    prompt="Port Name:    ")
    com.destroy()
    return comAddress #return the address used for serial connection

################ Main ######################
if __name__ == "__main__":
    # Instatiate home Xbee and open
    comAddress = xBeeParameters() #Get serial port
    baudRate = 9600 #set baud to serial radio rate
    try: #try to open the radio
        homeXbee = XBeeDevice(comAddress, baudRate) #open radio with baud and serial port
        homeXbee.open(force_settings=True) #force the programable settings
        print("Connection to home XBee made \n")
    except OSError: #if the port doesn't open send error and quit
        print("OSError, failed connection. \n")
        message = tk.Tk()
        message.withdraw()
        messagebox.showerror("ERROR", "The port you selected did not connect.")
        message.destroy()
        quit()


    # Instatiate remote xbee and open
    remoteXbeeAddress = "0013A20040DE1F34"## Address of the CPM Xbee Radio
    # "0013A200419F1EF1"
    remoteXbee = RemoteXBeeDevice(homeXbee, XBee64BitAddress.from_hex_string(remoteXbeeAddress))

    window = tk.Tk() #Window instance
    ## Create window
    windowParameters()
    window.title("DROPS GUI V2.3") #Title the window after drops version
    window.geometry(geoString) #Set the window size
    window.configure(background=windowBGColor) #Set window background color in Hex


    ################ CREATE WIDGETS ###################
    
    #Battery label
    Batt = tk.Label(window, text = "Battery Voltage", font=('Lekton 14'), 
    borderwidth = 3, relief="solid", bg=labelColorText) #Create Voltage label
    Batt.pack()
    Batt.place(bordermode = "outside", relwidth=1/3, relheight=1/6, relx = 0, rely = 0) #Position voltage label

    #Power label
    Pow = tk.Label(window, text = "Power Passthrough", font=('Lekton 14'), 
    borderwidth = 3, relief="solid", bg=labelColorText)
    Pow.pack()
    Pow.place(bordermode = "outside", relwidth=1/3, relheight=1/6, relx = 0, rely = 1/6)

    #Cargo label
    Cargo = tk.Label(window, text = "Cargo Bay", font=('Lekton 14'), 
    borderwidth = 3, relief="solid", bg=labelColorText)
    Cargo.pack()
    Cargo.place(bordermode = "outside", relwidth=1/3, relheight=1/6, relx = 0, rely = 2/6)

    #Latch label
    Latch = tk.Label(window, text = "Latch Status", font=('Lekton 14'),
    borderwidth = 3, relief="solid", bg=labelColorText)
    Latch.pack()
    Latch.place(bordermode = "outside", relwidth=1/3, relheight=1/6, relx = 0, rely = 3/6)

    #Time label
    Time = tk.Label(window, text = "Timestamp", font=('Lekton 14'), 
    borderwidth = 3, relief="solid", bg=labelColorText)
    Time.pack()
    Time.place(bordermode = "outside", relwidth=1/3, relheight=1/6, relx = 0, rely = 4/6)

    ## Display input values

    #Battery Voltage
    BattVolt = tk.Label(window, 
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=labelColorValue)
    BattVolt.pack()
    BattVolt.place(relwidth=(1/2-1/3), relheight=1/6, relx = 1/3, rely = 0)

    #Power status
    PowStat = tk.Label(window, 
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=labelColorValue)
    PowStat.pack()
    PowStat.place(relwidth=(1/2-1/3), relheight=1/6, relx = 1/3, rely = 1/6)

    #Cargo Status
    CargoStat = tk.Label(window, 
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=labelColorValue)
    CargoStat.pack()
    CargoStat.place(relwidth=(1/2-1/3), relheight=1/6, relx = 1/3, rely = 2/6)

    #Latch Status
    LatchStat = tk.Label(window, 
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=labelColorValue)
    LatchStat.pack()
    LatchStat.place(relwidth=(1/2-1/3), relheight=1/6, relx = 1/3, rely = 3/6)

    #Timestamp
    Timestamp = tk.Label(window, 
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=labelColorValue)
    Timestamp.pack()
    Timestamp.place(relwidth=(1/2-1/3), relheight=1/6, relx = 1/3, rely = 4/6)


    ## Button for latch
    latch = tk.Button(window, text = "LATCH", font=("STIX Math", 20),borderwidth = 3,
    command = latchCommand,
    relief="solid", bg=buttonBackgroundP, activebackground=buttonBackgroundA)
    latch.pack()
    latch.place(relwidth=(1/2), relheight=1/6, relx = 0, rely = 5/6)

     ## Button for unlatch
    latch = tk.Button(window, text = "UNLATCH", font=("STIX Math", 20),borderwidth = 3,
    command = unlatchCommand,
    relief="solid", bg=unlatchButtonP, activebackground=unlatchButtonA)
    latch.pack()
    latch.place(relwidth=(1/2), relheight=1/6, relx = 1/2, rely = 5/6)

    ## Logo
    logo = tk.Label(window, text = "DROPS", font=("Letkon MS", 50, "bold"),borderwidth = 3, \
     relief="solid", bg=labelColorValue, fg='#000000')
    logo.pack()
    logo.place(relwidth=(1/2), relheight=1/3, relx = 1/2, rely = 0)

    ## Latches

    #Latch 1
    Latch1 = tk.Label(window, \
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=latchOpen)
    Latch1.pack()
    Latch1.place(relwidth=(1/4), relheight=1/4, relx = 1/2, rely = 2/6)

    #Latch 2
    Latch2 = tk.Label(window, \
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=latchOpen)
    Latch2.pack()
    Latch2.place(relwidth=(1/4), relheight=1/4, relx = 3/4, rely = 2/6)

    #Latch 3
    Latch3 = tk.Label(window, \
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=latchOpen)
    Latch3.pack()
    Latch3.place(relwidth=(1/4), relheight=1/4, relx = 1/2, rely = 7/12)

    #Latch 4
    Latch4 = tk.Label(window, \
    font=("STIX Math", 20),borderwidth = 3, relief="solid", bg=latchOpen)
    Latch4.pack()
    Latch4.place(relwidth=(1/4), relheight=1/4, relx = 3/4, rely = 7/12)



    ## Main loop to keep the window open
    startData()
    updateData() #run update data once to populate GUI
    window.mainloop()
    homeXbee.close() # Close XBee connection
    print("Closed Connection \n")

