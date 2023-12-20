#std
import struct
import os
import subprocess
import urllib.request
import json

#thirdparty
import asyncio

#local

async def main():

    with urllib.request.urlopen("https://bot.tf2maps.net/api/v3/maps/") as url:
        data = json.load(url)

        botlist = []

        for map in data:
            botlist.append(map['map']+ '.bsp')

    bsps_path = "/home/tf/tf/custom/maptests/maps/"
    fastdl_path = "/var/www/html/maps/"
    maps_in_dir = os.listdir(bsps_path)
    for map in maps_in_dir:
        if map.endswith(".bsp"):
            if map in botlist:
                #print("Checking: " + map)
                filesize = os.stat(bsps_path + str(map)).st_size
                #print(str(int(filesize)) + " bsp size")
                
                cmd = f"bzcat {fastdl_path}/{map}.bz2 | wc -c"
                ps = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
                output = ps.communicate()[0]
                #print(str(int(output)) + " bz2 decompressed")

                if int(output) != filesize:
                    print(map + " is trunked!")
                    os.remove(fastdl_path + map + ".bz2")
            else:
                print(map + " is not on the botlist, skipping.")

#loooooop
loop = asyncio.get_event_loop()
try:
    loop.run_until_complete(main())
except KeyboardInterrupt:
    pass
finally:
    loop.stop()
