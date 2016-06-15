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

For **MacOS** users you don't have to done much more, simply install this little [driver](http://raysfiles.com/drivers/ch341ser_mac.zip) (direct download) and you'll be ready to roll out !
>> You may have some difficulties to upload code to your Node with MacOS, care to unplug and plug your device again before sending data, don't hesitate to send it multiple times I can't say why but sometimes it fail for nothing on MacOS

## Getting started
The first thing we need is to flash your device

To do so just run this command :

`python esptool.py --port /dev/ttyUSB0 write_flash 0x00000 /path/to/your/build.bin`

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

What we can see is that I did not choose to activate SSL, I have 11 modules included, and we're using Lua 5.1.4

## Just do it

The last thing you need to know is how to code on it

As I told you, NodeMCU has a Lua interpreter so, just as any script languages, you have 2 options :

 - Write your code directly on the `screen` input, but that's not really awesome...
 - Write a file on your NodeMCU to make it execute automatically

Well, as you can see you don't have any file explorer, neither text editor on your NodeMCU

That's what about LuaTool will help you, instead of asking your NodeMCU to write down in a file your code line by line at hand, we'll use LuaTool, which automate this annoying steps for us

We'll use it this way :
`python luatool.py --port /dev/ttyUSB0 --src myScript.lua --dest myScript.lua`

 - `--dest myScript.lua` is optionnal, by default `--src` argument will be used

You should have an output like this :
```
./luatool.py --port /dev/ttyUSB0 --src buzzer.lua 

->file.open("buzzer.lua", "w") -> ok
->file.close() -> ok
->file.remove("buzzer.lua") -> ok
->file.open("buzzer.lua", "w+") -> ok
->file.writeline([==[buzzerPin = 5]==]) -> ok
->file.writeline([==[gpio.mode(buzzerPin, gpio.OUTPUT)]==]) -> ok
->file.writeline([==[]==]) -> ok
->file.writeline([==[tones = {}]==]) -> ok

...

->file.writeline([==[beep(buzzerPin, "aS", 100)]==]) -> ok
->file.writeline([==[end]==]) -> ok
->file.writeline([==[]==]) -> ok
->file.writeline([==[tmr.alarm(0, 1000, 1, function() play() end )]==]) -> ok
->file.flush() -> ok
->file.close() -> ok
--->>> All done <<<---

```

I used my `buzzer.lua` script for this example, you will found it [here](https://github.com/Hydhen/NodeMCU/blob/master/Buzzer/buzzer.lua)

Once you're done, just `screen` on your NodeMCU and use the `dofile` function :
```
> dofile("buzzer.lua")
> Frequency:523
Frequency:659
Frequency:880
Frequency:523
Frequency:659
Frequency:880
...
```

As my script is looping using `tmr.alarm()` it will never end until you restart your NodeMCU or unplug the cable

## It's over

That's all for this brief overview of the NodeMCU

Do not hesitate if you have any suggestion or improvment to this document

Enjoy :smiley:

## Bonus :

Here you'll find some tips and tricks you may discover about Lua interpreter or the NodeMCU itself

### `print()` function :

In your Lua shell, to print a result you mostly use the `print()` function, but we have a shorter way to do the same thing

Here is an example of the `print()` function :

```
> number = 42
> string = "Hello, world!"
> addition = add(40,2)
> print(number)
42
> print(string)
Hello, world!
> print(addition)
42
> print(number .. ' ' .. string .. ' ' .. addition)
42 Hello, world! 42
```

And you can use the shortcut `=` :

```
> = number
42
> = string
Hello, world!
> = add(1,2)
3
> = number .. string .. add(1,2)
42Hello, world!3
```
