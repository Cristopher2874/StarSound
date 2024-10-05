# Below shows the steps to accessing a certain fits files and opening it
import matplotlib.pyplot as plt
from astropy.visualization import astropy_mpl_style
plt.style.use(astropy_mpl_style)


from astropy.utils.data import get_pkg_data_filename
from astropy.io import fits

#call in the file and extract in image
for i in range(0,57):
    try:
        file_name = r'C:\Users\Gokus\OneDrive\Escritorio\ImageProcess\James-Webb-Space-Telescope-Tutorial-main\test_fits\file_'+i+'.fits' #specify your path and fits file here
        image_file = get_pkg_data_filename(file_name)
        image_data = fits.getdata(image_file, ext=1)

        plt.axis ('off')
    # The data can be in the form of a 2D or 3D array

    #plt.imshow(image_data[0,:,:],origin = 'lower' ,cmap='gray')  # 3D version
        plt.imshow(image_data,cmap='gray')  # 2D version

    #creating a saving the image
        image_name = 'created_image'+i+'.png'
        fig1 = plt.gcf()
        plt.imsave(r'C:\Users\Gokus\OneDrive\Escritorio\ImageProcess\James-Webb-Space-Telescope-Tutorial-main\output\images' + image_name ,image_data,cmap = 'Greys_r')
    except Exception:
        print("Error accessing file")