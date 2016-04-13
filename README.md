# NodeMCU
Documentation about NodeMCU

## What you should know
 - I'm working with a NodeMCU 1.0 rev3 from Wemos.cc
 - It has a Lua interpreter embedded
 - I didn't figure out how to use the Node as an Arduino with ArduinoIDE, so I will only speak for Lua part for now
 - NodeMCU has only 1 analog input, and 8 digital inputs

## Choose your weapon
Now that you know what's inside NodeMCU, we have few scripts to download that will make your journey far far easier with NodeMCU

 - [ESPTool](https://github.com/themadinventor/esptool)

> This tool will be use to flash you NodeMCU firmware

 - [LuaTool](https://github.com/4refr0nt/luatool)

> LuaTool will upload your file on the NodeMCU for you (otherwise you have to write every line on your own... you don't want it, really)

 - [NodeMCU-CustomFirmware](http://nodemcu-build.com/index.php)

> This website allow you to create your own firmware based on what you need, just give your email address and you'll get your build in attached file

The last thing we need is a **Serial Terminal**

If you're on **Windows** you will have to use one like [PuTTY](http://www.putty.org/)

Otherwise, we'll use the `screen` package

## Getting started
The first thing we need is to flash your device

To do so just run this command :

`python esptool --port /dev/ttyUSB0 write_flash 0x00000 /path/to/your/build.bin`

You should have an output like :
```
Connecting...
Erasing flash...
Took 1.97s to erase flash block
Wrote 420864 bytes at 0x00000000 in 41.1 seconds (82.0 kbit/s)...

Leaving...
```

Which means everything is fine for now

## NodeMCU User phone
Connect to your NodeMCU :

`screen /dev/ttyUSB0`
> Default baud rate works for me here so I don't have to specify it

Once you're connected, you should have an empty screen, that's fine, just ask your friend to reboot :

`node.restart()`
> If you cannot write anything, try to unplug the USB, plug it again and screen on it

Here's the output I got :
```
node.restart()
> ��x!�D����DLH�
                =�

NodeMCU custom build by frightanic.com
        branch: master
        commit: c8037568571edb5c568c2f8231e4f8ce0683b883
        SSL: false
        modules: bit,bmp085,cjson,file,gpio,i2c,net,node,tmr,uart,wifi
 build  built on: 2016-04-13 15:26
 powered by Lua 5.1.4 on SDK 1.4.0
lua: cannot open init.lua
>
```

Don't mind about the scrap on first lines, it doesn't matter :smile:

What we can see is that I did not should to activate SSL, I have 11 modules included, and we're using Lua 5.1.4


