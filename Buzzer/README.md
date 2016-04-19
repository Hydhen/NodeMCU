# ReadMe

All the code in `buzzer.lua` was modified from this [post](http://www.areresearch.net/2015/04/esp8266-esp-01-nodemcu-playing-imperial.html)
> Click on the link it's an awesome Imperial March for your buzzer !

I have just reduced it to what I needed

## Requirements

In order to work properly, this script needs your NodeMCU to embed at least :

 - `gpio` module
 > Which is used to control your input/output pin, for more, read the [manual](http://nodemcu.readthedocs.org/en/dev/en/modules/gpio/)

 - `pwm` module
 > Which allow you to modulate frequencies on your gpio, for more, read the [manual](http://nodemcu.readthedocs.org/en/dev/en/modules/pwm/)
