require 'json'

PATH_TO_FILE = '/etc/hosts'
START_STRING = '# MANAGED BY FOCUS SCRIPT - START'
END_STRING = '# MANAGED BY FOCUS SCRIPT - END'
CONFIG = JSON.load(File.open('./config.json', 'r')).freeze
