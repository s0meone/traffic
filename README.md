Traffic: the traffic information gem
====================================

Traffic is a gem that supplies traffic information from multiple data providers

Installation
------------
	gem install traffic

Usage Examples
--------------
	require "traffic"

	info = Traffic.from(:file_index)
	
	info = Traffic.from(:file_index, File.read("/tmp/archive.xml"))
	
	puts info.count
	 #=> 15
	puts "#{info.size} km"
	 #=> "45 km"

	info_item = info.items.first
	
	puts "#{info_item.from} to #{info_item.to}
	 #=> "Amsterdam to Amersfoort"
	puts info_item.road
	 #=> "A1"
	puts "#{info_item.length} km"
	 #=> "2.8 km"
	puts "#{info_item.description} - #{info_item.location} - #{info_item.cause}"
	 #=> "stilstaand verkeerd - Eemnes en Eembrugge - defecte vrachtwagen"
	puts "#{info_item.from_location} - #{info_item.to_location}"
	 #=> "40.0 - 42.8"
 	 
Providers
---------
Dutch traffic information from [fileindex.nl](http://www.fileindex.nl/) and [ANWB](http://www.anwb.nl)

Testing
-------
Run all tests:

	rspec spec/

Copyright
---------
Copyright (c) 2011 Daniël van Hoesel.