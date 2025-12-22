# Help :
# python ./generate-parts.py help

import os
import csv
import sys

if len(sys.argv) > 1:
    PartType = sys.argv[1]
else:
    PartType = ""

print("start...")

quote = "\\\""

# parse ./stl directory
for path, subdirs, files in os.walk('./stl'):
    files = [ file for file in files if file.endswith( ('.stl') ) ]
    for name in files:
        print(name)
        print(path)
        # check if path exist
        # datPath = path.replace("./stl", "./dat/parts")
        datPath = "./dat/parts"
        datName = name.replace(".stl", ".dat")
        if not os.path.exists(datPath):
            os.makedirs(datPath)
        command = "python ./stlToDat.py " + path + "/" + name + " " + datPath + "/" + datName
        print(command)
        os.system(command)


# Read extensions.csv
with open('extensions.csv', newline='') as csvExtensions:
    dialect = csv.Sniffer().sniff(csvExtensions.read(2048), delimiters=";")   
    csvExtensions.seek(0)
    ReaderExtensions = csv.DictReader(csvExtensions, dialect=dialect)

    file = open("openscad-commands.txt","w")    
    if "help" in PartType:
        print ("Usage : generate-parts.py <extension_name>")
        print ("Extenstion list :")
        for rowExtensions in ReaderExtensions:
            print (rowExtensions['Name'])
        sys.exit()    

    for rowExtensions in ReaderExtensions:
        #For all categories
        #Create path
        
        if not os.path.exists(rowExtensions['stl_directory']):
            os.makedirs(rowExtensions['stl_directory'])

        if 'bricks' in rowExtensions['Name'] and (PartType == "" or PartType == "bricks"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                reader = csv.DictReader(csvfile, dialect='excel')
                
                for row in reader:
                    params = row['Name'].split("-")
                    model = params[0]
                    length1 = params[1] if len(params) > 1 else 1
                    length2 = params[2] if len(params) > 2 else 1
                    length3 = params[3] if len(params) > 3 else 1
                    filename = row['Name'] + ".stl"
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['Name'] + ".stl" + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + model + quote
                    stl += " -D length1=" + str(length1)
                    stl += " -D length2=" + str(length2)
                    stl += " -D length3=" + str(length3)                    
                    #stl = "openscad -o ./stl/basic/{4} clip_and_block.scad -D model=\\\"{0}\\\" -D length1={1} -D length2={2} -D length3={3}".format(model, length1, length2, length3, filename)
                    file.write(stl + "\n")    
                    print(stl)
                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    file.write(preview + "\n")  
                                       

            # Create zip
            file.write("mkdir -p ./assets/zip && ( cd ./assets/stl && zip -r ../zip/bricks.stl.zip bricks )" + "\n") 

        if 'clips' in rowExtensions['Name'] and (PartType == "" or PartType == "clips"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                print(reader.fieldnames)
                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n") 
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                      

        if 'lockers' in rowExtensions['Name'] and (PartType == "" or PartType == "lockers"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                print(reader.fieldnames)
                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n") 
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")    

        if 'screw-nut' in rowExtensions['Name'] and (PartType == "" or PartType == "screw-nut"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                print(reader.fieldnames)
                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n") 
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                                        

        if 'twist' in rowExtensions['Name'] and (PartType == "" or PartType == "twist"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                reader = csv.DictReader(csvfile, dialect='excel')
                
                for row in reader:
                    params = row['Name'].split("-")
                    model = params[0]
                    length1 = params[1] if len(params) > 1 else 1
                    length2 = params[2] if len(params) > 2 else 1
                    length3 = params[3] if len(params) > 3 else 1
                    filename = row['Name'] + ".stl"
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['Name'] + ".stl" + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + model + quote
                    stl += " -D length1=" + str(length1)
                    stl += " -D length2=" + str(length2)
                    stl += " -D length3=" + str(length3)
                    #stl = "openscad -o ./stl/basic/{4} clip_and_block.scad -D model=\\\"{0}\\\" -D length1={1} -D length2={2} -D length3={3}".format(model, length1, length2, length3, filename)
                    file.write(stl + "\n")    
                    print(stl)

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    file.write(preview + "\n") 

        if 'plates' in rowExtensions['Name'] and (PartType == "" or PartType == "plates"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                reader = csv.DictReader(csvfile, dialect='excel')
                
                for row in reader:
                    params = row['Name'].split("-")
                    model = params[0]
                    length1 = params[1] if len(params) > 1 else 1
                    length2 = params[2] if len(params) > 2 else 1
                    length3 = params[3] if len(params) > 3 else 1
                    filename = row['Name'] + ".stl"
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['Name'] + ".stl" + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + model + quote
                    stl += " -D length1=" + str(length1)
                    stl += " -D length2=" + str(length2)
                    stl += " -D length3=" + str(length3)
                    #stl = "openscad -o ./stl/basic/{4} clip_and_block.scad -D model=\\\"{0}\\\" -D length1={1} -D length2={2} -D length3={3}".format(model, length1, length2, length3, filename)
                    file.write(stl + "\n")    
                    print(stl)

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                     

        if 'springs' in rowExtensions['Name'] and (PartType == "" or PartType == "springs"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                reader = csv.DictReader(csvfile, dialect='excel')
                
                for row in reader:
                    params = row['Name'].split("-")
                    model = params[0]
                    length1 = params[1] if len(params) > 1 else 1
                    length2 = params[2] if len(params) > 2 else 1
                    length3 = params[3] if len(params) > 3 else 1
                    filename = row['Name'] + ".stl"
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['Name'] + ".stl" + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + model + quote
                    stl += " -D length1=" + str(length1)
                    stl += " -D length2=" + str(length2)
                    stl += " -D length3=" + str(length3)
                    #stl = "openscad -o ./stl/basic/{4} clip_and_block.scad -D model=\\\"{0}\\\" -D length1={1} -D length2={2} -D length3={3}".format(model, length1, length2, length3, filename)
                    file.write(stl + "\n")    
                    print(stl)

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                     

        if 'tech' in rowExtensions['Name'] and (PartType == "" or PartType == "tech"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                print(reader.fieldnames)
                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n")    
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                                      
                    
        if "breakout-boards" in rowExtensions['Name'] and (PartType == "" or PartType == "breakout-boards"):
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)

                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n")    
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")  

        if "gears" in rowExtensions['Name'] and (PartType == "" or PartType == "gears"):
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)

                for row in reader:
                    print (row)
                    command = "openscad -o " + rowExtensions['stl_directory'] + '/' +  row['FileName'] + ".stl" + " " + rowExtensions['scad_file']
                    command += " -D " + row['Options']
                    print (command)
                    file.write(command + "\n")    
                    #Generate preview
                    preview = command.replace(".stl", ".png", 1)
                    file.write(preview + "\n")                              


        if 'lego' in rowExtensions['Name'] and (PartType == "" or PartType == "lego"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                
                for row in reader:
                    # Generate STL
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' + row['Filename'] + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + row['Model'] + quote
                    stl += " -D width=" + row['width']
                    stl += " -D length=" + row['length']
                    stl += " -D height=" + row['height']
                    stl += " -D width2=" + row['width2']
                    stl += " -D length2=" + row['length2']
                    stl += " -D holeArray=" + row['holeArray'] 
                    print (stl)
                    file.write(stl + "\n")

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    #Preview in another directory
                    #preview = preview.replace("electronic", "electronic/preview", 1) 
                    file.write(preview + "\n")                    

        if 'spiralwheel' in rowExtensions['Name'] and (PartType == "" or PartType == "spiralwheel"):
            print (csv.list_dialects())
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)
                
                for row in reader:
                    # Generate STL
                    stl = "openscad --render -o " + rowExtensions['stl_directory'] + '/' + row['Filename'] + " " + rowExtensions['scad_file']
                    stl += " -D type=" + quote + row['type'] + quote
                    stl += " -D dia_out=" + row['dia_out']
                    stl += " -D height=" + row['height']
                    stl += " -D spoke_count=" + row['spoke_count']
                    stl += " -D spoke_thickness=" + row['spoke_thickness']
                    stl += " -D tread_tickness=" + row['tread_tickness']
                    stl += " -D r1=" + row['r1'] 
                    stl += " -D r2=" + row['r2'] 
                    print (stl)
                    file.write(stl + "\n")

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    #Preview in another directory
                    #preview = preview.replace("electronic", "electronic/preview", 1) 
                    file.write(preview + "\n")                    

        if "import-parts" in rowExtensions['Name'] and (PartType == "" or PartType == "import-parts"):
            with open(rowExtensions['csv_file'], newline='') as csvfile:
                #Read csv file
                dialect = csv.Sniffer().sniff(csvfile.read(2048), delimiters=";")   
                csvfile.seek(0)
                reader = csv.DictReader(csvfile, dialect=dialect)

                for row in reader:
                    if not os.path.exists(rowExtensions['stl_directory'] + '/' + row['Directory']):
                        os.makedirs(rowExtensions['stl_directory'] + '/' + row['Directory'])                    
                    # Generate STL
                    stl = "openscad -o " + rowExtensions['stl_directory'] + '/' + row['Directory'] + '/' + row['Filename'] + " " + rowExtensions['scad_file']
                    stl += " -D model=" + quote + row['Model'] + quote
                    stl += " -D filename=" + quote + row['STL_source'] + quote
                    stl += " -D holeArray=[" + row['holeArray'] + "]"
                    stl += " -D finalRotate=" + row['finalRotate']                        
                    stl += " -D finalMirror=" + row['finalMirror']    
                    print (stl)
                    file.write(stl + "\n")

                    #Generate preview
                    preview = stl.replace(".stl", ".png", 1)
                    #Preview in another directory
                    #preview = preview.replace("electronic", "electronic/preview", 1) 
                    file.write(preview + "\n")
                    #TODO : 1 image ? https://stackoverflow.com/questions/30227466/combine-several-images-horizontally-with-python


       


    file.close()

#sys.exit()       

for command in open('openscad-commands.txt'):
    print(command)
    os.system(command)