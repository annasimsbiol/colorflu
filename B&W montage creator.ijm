/*Created by Anna Sims, 20/1/2020
 * Macro creates a montage using black and white images and the merge images from B&W presentation macros
 * Only suitable for two channels
 * Adds scale bar 
 */


#@ File (label = "Input directory", style = "directory") input
//#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
		print(list[i]);
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}

function processFile(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	//print("file is" + file);
	open(input + File.separator + file);
	title = getTitle();
	name = getTitle();
	prefix = substring (name, 0, lastIndexOf(name,"_"));
	//print("the title is: " + title);
	if(indexOf(title, "b&w") >= 0) {
		//print("I identified some black and white images");
	run("RGB Color"); 
	//print("I made the black images stackable");
	}
	if (nImages == 9){
		//print("I noticed there are 9 images open");
	//close("*");
	//print("this might work!");
	run("Images to Stack", "name=Stack title=[] use keep");
	run("Make Montage...", "columns=3 rows=3 scale=0.25 border=2");
	setTool("line");
	makeLine(1286, 1424, 1433, 1424);
	//print("I've drawn a line!");
	run("Set Scale...", "distance=166.6 known=2 unit=mm");
	//print("I set the scale!");
	run("Scale Bar...", "width=2 height=10 font=30 color=White background=None location=[Upper Left] bold");
	//print("I made a scale bar!");
	saveAs("tiff", input + File.separator + prefix + "_montage");	
	close("*");
	}
}
	