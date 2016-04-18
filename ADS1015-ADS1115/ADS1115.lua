-- Requirements
bit = require("bit")

-- Global variable for i2c
SDA                                 = 2
SCL                                 = 3

-- Global variable for ADS1115
ADDR                                = 0x48

ADS1115_CONVERTIONDELAY             = 8

ADS1015_REG_POINTER_MASK            = 0x03
ADS1015_REG_POINTER_CONVERT         = 0x00
ADS1015_REG_POINTER_CONFIG          = 0x01
ADS1015_REG_POINTER_LOWTHRESH       = 0x02
ADS1015_REG_POINTER_HITHRESH        = 0x03

ADS1015_REG_CONFIG_MUX_SINGLE_0     = 0x4000
ADS1015_REG_CONFIG_MUX_SINGLE_1     = 0x5000
ADS1015_REG_CONFIG_MUX_SINGLE_2     = 0x6000
ADS1015_REG_CONFIG_MUX_SINGLE_3     = 0x7000

ADS1015_REG_CONFIG_OS_SINGLE        = 0x8000

ADS1015_REG_CONFIG_CQUE_NONE        = 0x0003
ADS1015_REG_CONFIG_CLAT_NONLAT      = 0x0000
ADS1015_REG_CONFIG_CPOL_ACTVLOW     = 0x0000
ADS1015_REG_CONFIG_CMODE_TRAD       = 0x0000
ADS1015_REG_CONFIG_DR_1600SPS       = 0x0080
ADS1015_REG_CONFIG_MODE_SINGLE      = 0x0100


-- Functions
function readRegister(address, reg)
    i2c.start(0)
    i2c.address(0, address, i2c.TRANSMITTER)
    i2c.write(0, reg)
    i2c.stop(0)

    i2c.start(0)
    i2c.address(0, address, i2c.RECEIVER)
    ret = i2c.read(0, 2)
    i2c.stop(0)

    return ret
end

function writeRegister(address, reg, value)
    i2c.start(0)
    i2c.address(0, address, i2c.TRANSMITTER)
    i2c.write(0, reg)
    high = 0
    high = bit.rshift(value, 8)
    i2c.write(0, high)
    low = 0
    low = bit.band(0xFF)
    i2c.write(0, low)
    i2c.stop(0)
end


function readADC_SingleEnded(channel)
    if channel > 3 then
        return 0
    end


    config = 0
    config = bit.bor(config, ADS1015_REG_CONFIG_CQUE_NONE)
    config = bit.bor(config, ADS1015_REG_CONFIG_CLAT_NONLAT)
    config = bit.bor(config, ADS1015_REG_CONFIG_CPOL_ACTVLOW)
    config = bit.bor(config, ADS1015_REG_CONFIG_CMODE_TRAD)
    config = bit.bor(config, ADS1015_REG_CONFIG_DR_1600SPS)
    config = bit.bor(config, ADS1015_REG_CONFIG_MODE_SINGLE)

    if channel == 0 then
        config = bit.bor(config, ADS1015_REG_CONFIG_MUX_SINGLE_0)
    elseif channel == 1 then
        config = bit.bor(config, ADS1015_REG_CONFIG_MUX_SINGLE_1)
    elseif channel == 2 then
        config = bit.bor(config, ADS1015_REG_CONFIG_MUX_SINGLE_2)
    elseif channel == 3 then
        config = bit.bor(config, ADS1015_REG_CONFIG_MUX_SINGLE_3)
    end

    config = bit.bor(config, ADS1015_REG_CONFIG_OS_SINGLE)

    writeRegister(ADDR, ADS1015_REG_POINTER_CONFIG, config)

    tmr.delay(ADS1115_CONVERTIONDELAY)

    ret = readRegister(ADDR, ADS1015_REG_POINTER_CONVERT)

    print (ret)

    return ret
end

print('I2C_SETUP...')
i2c.setup(0, SDA, SCL, i2c.SLOW)
print('SET UP')

function accelerometer()
    a = readADC_SingleEnded(0)
    b = readADC_SingleEnded(1)
    c = readADC_SingleEnded(2)
    print("1: " .. a)
    print("2: " .. b)
    print("3: " .. c)
end

tmr.alarm(0, 1000, 1, function() accelerometer() end )
