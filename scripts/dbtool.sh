#!/bin/sh
pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}

menu() 
{
	clear
	echo ""
	echo "===================================="	
	echo "============ DBtool ================"
	echo "===================================="
	echo "0) Connect to mysql? - Press 0"
	echo "1) Show databases? - Press 1"
	echo "2) Create a database? - Press 2"
	echo "3) Drop a database? - Press 3"
	echo "4) Import a database dump? - Press 4"
	echo "5) Export a database dump? - Press 5"
	echo "q) Quit? - Press q"
	echo ""
}

menu
while :
	do
		read -p "What do you want to do? " INPUT_STRING
		case $INPUT_STRING in
		0)
			clear
				mysql -u root -p
				echo ""
				pause
				menu
			;;
		1)
			clear
			echo "Show Databases"
			echo "=================="
			echo ""			
				mysql -u root -p -e "show databases;"
				echo ""
				pause
				menu
			;;
		2)
			clear
			echo "New Database Creation"
			echo "======================"
			echo ""
			read -p "Insert the Database Name: "  DB_NAME
				mysqladmin -u root -p --verbose create $DB_NAME
			echo ""
			pause
				menu			
			;;
		3)
			clear
			read -p "Insert the DATABASE NAME: "  DB_NAME
				mysqladmin -u root -p drop $DB_NAME -v
			echo ""
			pause
				menu		
			;;
		4)
			echo "Database data import"
			echo "======================"
			echo ""
			read -p "Insert the DATABASE NAME: "  DB_NAME
			read -p "Enter the PATH of the dump (path/dumpName.slq): " dumpName
			echo ""
			echo "Enter the database password in the next step ..."
				mysql -u root -p -h localhost -v $DB_NAME < $dumpName
			echo ""
			pause
			menu
			;;
		5)
			echo "Database data export"
			echo "======================"
			echo ""
			read -p "Insert the DATABASE NAME: "  DB_NAME
			read -p "Enter the file name for the dump: " DUMP_NAME
			echo ""
				[ -d dump ] $(mkdir dump) #if the folder dump is not present, create it
				mysqldump -h localhost -u root -p -v $DB_NAME > $(pwd)"/dump/"$DUMP_NAME
			echo ""
			echo "You can find your dump file in: "$(pwd)"/dump/"$DUMP_NAME
			pause
			menu
			;;
		q)
			echo ""
			echo "Bye!"
			break
			;;
		*)
			echo "Sorry, I don't understand ... choose an option from the menu or press q to exit."
			;;
		esac
done