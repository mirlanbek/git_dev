
#Positional arguments:

#./start.sh -n Mirlan
#start.sh == $0
#'-n' == $1
#'Mirlan' == $2
#
#file_name(script_name or command) == '$0'
#whatever comes after == argument $1
#whatever comes after == argument $2
#whatever comes after == argument $3
#.
#.
#.
#
#whatever comes after == argument $N





echo "Salam dostor bul scripttin aty $0"
sleep 3

echo $@
echo $#

MY_NAME=$1


die() {
    echo $1
    exit 1
}


command=ls
$command

if [ $? != 0 ]; then
	die " $command degen kommanda jok eken"
fi


chyk() {

echo "i'm func name: $0"
echo " i'm func's dol one $1"
echo " i'm $2"



}

chyk "$MY_NAME Tokonbekov" Nurken

