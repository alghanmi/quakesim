package edu.usc.sirlab.tools;

import java.io.*;

public class InSARParser {
	
	public InSARParser(File location) throws IOException {
		File[] files = location.listFiles();
		int count = 0;
		//*
		for(File file : files) {
			if(!file.isFile())
				break;
			count++;
			//System.out.println(file.getName());
			parseFile(file);
			
		}
		
		System.out.println("Total = " + count);

	}
	
	private void parseFile(File file) throws IOException {
		BufferedReader in = new BufferedReader(new FileReader(file));
		double lat_1 = 0, lat_2 = 0, lat_3 = 0, lat_4 = 0;
		double lon_1 = 0, lon_2 = 0, lon_3 = 0, lon_4 = 0;
		double timespan = 0;
		int width = 0, length = 0;
		String date = "";
		
		String[] fileNameSplit = file.getName().split("-");
		String dirname = fileNameSplit[0] + "-" + fileNameSplit[1];
		String dataFileName = file.getName().substring(0, file.getName().length() - 4);
		
		
		//System.out.println(dirname + "/" + dataFileName);
		
		String line;
		while((line = in.readLine()) != null) {
			if(line.equalsIgnoreCase(""))
				continue;
			
			String[] data = line.trim().split(" ");
			if(line.startsWith("LAT_REF1"))
				lat_1 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LAT_REF2"))
				lat_2 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LAT_REF3"))
				lat_3 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LAT_REF4"))
				lat_4 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LON_REF1"))
				lon_1 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LON_REF2"))
				lon_2 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LON_REF3"))
				lon_3 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("LON_REF4"))
				lon_4 = Double.parseDouble(data[data.length - 1]);
			else if(line.startsWith("DATE12"))
				date = data[data.length - 1];
			else if(line.startsWith("WIDTH"))
				width = Integer.parseInt(data[data.length - 1]);
			else if(line.startsWith("FILE_LENGTH"))
				length = Integer.parseInt(data[data.length - 1]);
			else if(line.startsWith("TIME_SPAN_YEAR"))
				timespan = Double.parseDouble(data[data.length - 1]);
		}
		if(lat_1 == 0)
			System.out.println(file.getName() + " has lat_1 = 0");
		if(lat_2 == 0)
			System.out.println(file.getName() + " has lat_2 = 0");
		if(lat_3 == 0)
			System.out.println(file.getName() + " has lat_3 = 0");
		if(lat_4 == 0)
			System.out.println(file.getName() + " has lat_4 = 0");
		if(lon_1 == 0)
			System.out.println(file.getName() + " has lon_1 = 0");
		if(lon_2 == 0)
			System.out.println(file.getName() + " has lon_2 = 0");
		if(lon_3 == 0)
			System.out.println(file.getName() + " has lon_3 = 0");
		if(lon_4 == 0)
			System.out.println(file.getName() + " has lon_4 = 0");
		if(width == 0)
			System.out.println(file.getName() + " has width = 0");
		if(length == 0)
			System.out.println(file.getName() + " has length = 0");
		if(timespan == 0)
			System.out.println(file.getName() + " has timespan = 0");
		if(date.equalsIgnoreCase(""))
			System.out.println(file.getName() + " has date = \"\"");
		
		String date1 = date.split("-")[0];
		String date2 = date.split("-")[1];
		
		
		
		String longDate1 = getYear(date1.substring(0, 2)) + "-" + date1.substring(2, 4) + "-" + date1.substring(4, 6);
		String longDate2 = getYear(date2.substring(0, 2)) + "-" + date2.substring(2, 4) + "-" + date2.substring(4, 6);
		
		//System.out.println(date + " -> " + longDate1 + ", " + longDate2);
		
		
		//date_start, date_end, timespan, width, length
		String myString = "";
		//myString += "\"" + + "\"" + ", ";
		myString += "\"" + "InSAR Interferogram " + longDate1 + " to " + longDate2 + "\"" + ", ";
		myString += "\"" +  "InSAR Interferogram obtained from Paul Lundgren at JPL" + "\"" + ", ";
		myString += "\"" + dirname + "/" + dataFileName + "\"" + ", ";
		myString += "\"" + dirname + "/" + file.getName() + "\"" + ", ";
		myString += "\"" + dirname + "/" + dataFileName + ".jpg" + "\"" + ", ";
		myString += "\"" + dirname + "/" + dataFileName + "-thumbnail.jpg" + "\"" + ", ";
		myString += lat_1 + ", ";
		myString += lon_1 + ", ";
		myString += lat_2 + ", ";
		myString += lon_2 + ", ";
		myString += lat_3 + ", ";
		myString += lon_3 + ", ";
		myString += lat_4 + ", ";
		myString += lon_4 + ", ";
		myString += "\"" + longDate1 + "\"" + ", "; //date start
		myString += "\"" + longDate2 + "\"" + ", "; //date end
		myString += timespan + ", ";
		myString += width + ", ";
		myString += length;
		myString += ");";
		
		
		myString = "INSERT INTO insar_interferogram(title, description, data_file_url, meta_file_url, image_url, thumbnail_url, point1_lat, point1_lon, point2_lat, point2_lon, point3_lat, point3_lon, point4_lat, point4_lon, date_start, date_end, timespan, width, length) VALUES(" + myString;
		System.out.println(myString);
			
		
	}
	
	private String getYear(String input) {
		if(input.startsWith("0")) {
			return "20" + input;
		}
		else
			return "19" + input;
	}
	
	public static void main(String[] args) throws IOException {
		new InSARParser(new File("/home/alghanmi/work/rsc"));
	}
}
