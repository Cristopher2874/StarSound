from astroquery.cadc import Cadc
import numpy as np
import requests
cadc = Cadc()
results = cadc.query_name('J1007+2853') # filter by target name
results = results[results['collection']=='JWST']# filter by archive 
results = results[results['dataRelease'] > '2022-01-29T00:00:00.000'] # filter by release date
Download_urls = cadc.get_data_urls(results)

#lastly, you can also automate the downloading process by following steps below.
numberOfFiles = len(Download_urls)
for urls in np.arange(0,numberOfFiles,1):
    r = requests.get(Download_urls[urls])
    #open('test_fits/file_'+str(urls)+'.fits','wb').write(r.content)
    open(r'C:\Users\Gokus\OneDrive\Escritorio\ImageProcess\James-Webb-Space-Telescope-Tutorial-main\test_fits\file_'+str(urls)+'.fits','wb').write(r.content)