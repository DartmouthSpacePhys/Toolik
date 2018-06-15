import ConfigParser

config = ConfigParser.SafeConfigParser()
config.read('/usr/local/etc/daq.conf')

print config.get('daq','datadir')
print config.get('daq','procdir')
print config.get('daq','fileglob')
