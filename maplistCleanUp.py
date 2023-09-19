# Std Lib Imports
import asyncio
import urllib.request
import json
import os

# 3rd Party Imports
import asyncssh

async def main():
    with urllib.request.urlopen("https://bot.tf2maps.net/apiv2/maps/") as url:
        data = json.load(url)

        botlist = []

        for map in data:
            botlist.append(map['map']+ '.bsp')

        path = '/home/tf/tf/custom/maptests/maps/'
        maps_in_dir = os.listdir(path)
        for map in maps_in_dir:
            if map in botlist:
                print("Do not remove:" + map)
            else:
                print("Remove: " + map)

                #4.62 gb
                os.remove(path + map)

                #10gb
                os.remove("/var/www/html/maps/" + map + ".bz2")
            pass

#loooooop
loop = asyncio.get_event_loop()
try:
    loop.run_until_complete(main())
except KeyboardInterrupt:
    pass
finally:
    loop.stop()
