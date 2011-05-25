# Plugins

The plugin system is designed to be simple. Each plugin is a simple Ruby script, like so:

    provides "load_average"
    load_average Mash.new

    raw_load_averages = %x[uptime|cut -d: -f4].strip.split(" ")

    load_average[:one_minute] = raw_load_averages[0]
    load_average[:five_minutes] = raw_load_averages[1]
    load_average[:fifteen_minutes] = raw_load_averages[2]
    
## Writing a plugin

An Overwatch plugin is nothing more a Ruby script that returns a hash. When the plugin is executed, the values of this hash are combined with the hashes from any other plugins and posted back to the Overwatch server

A plugin has three parts:

* a `provides` method that instantiates the hash
* the new `method` you created using the above provides method
* The code you want to use to populate the hash

## Adding plugins

When writing Overwatch, I tried a number of different setups to manage the plugin system. I first went with a global plugin repository like 