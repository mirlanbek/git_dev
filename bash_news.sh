#!/bin/bash
---------------------------------------------------------------------------------------------------------



echo $password | sudo -S iptables -F  ------ provide sudo password in the script

var="Mirlan"
echo ${#var}   ------ var's length  6 bt

--------------------------------------------------------------
timeout 5s top  ; timeout 5m ./script.sh #   ------- imp

md5sum file1 file2          # --------- compare 2 files if content exactly the same


###########################################

------------- automate ssh key gen and fingerprint no ask questions ------------------------

ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
sshpass -p '1' ssh-copy-id -o "StrictHostKeyChecking no" root@192.168.1.11

-----------------------------------------------
i=0
while [ $i -lt 5 ]; do
      echo salam
      (( i++ ))
done

-------- parted --------------------------------
sudo parted /dev/sda mklabel gpt

parted sda
print
mkpart
primary
start: 1
end: 5000    ---  for 5G
quit

rm 1   --  delet partition 1

---------------------------------

blockdev --setrw /dev/sda
mount /dev/sda -o remount,rw
hdparm -r 0 /dev/sda

### ****************

rsync -rlpzD source-1 dest
lshw -c disk                                          # HD info
udevadm info -q all -n /dev/sda | grep DEVPATH        # disk DEVPATH
sudo ntpdate -s corp.intel.com                        # NTP sync

sed -e 's/^"//' -e 's/"$//'   # --- strip output


## *********************  cat ****************************** 
cat << EOF

Run following command to activate virtualenv and run Ansible:

                  source ~/.venv/bin/activate

EOF


cat > /etc/environment  << EOF

http_proxy=http://ip:912

EOF

## *********************  upercase value of var ****************************** 
cat /proc/cmdline
var=${a^^} = = make value uppercase

## ********************* SELECT **** like read input  ****************************** 

select s in `ls` ;do 
new_var=$s
break
done
echo $new_var


## ********************* ${var::-1}  ****************************** 
var=mirlan5

echo ${var::-3} #  "mirl" chygat, t.e "::-3" b-so on jagynan 3 char jeit  "mirl" chygat.  
echo ${var:3}    #  "lan5" chygat, t.e ":3" b-so sol jagynan 3 char jeit  "lan5" chygat.  
echo ${var::3} # ---> birinchi 3 char chygat "mir" 

echo ${var#mi}  ---- "#" ----- bash jagynan "mi" degen dal kelse remove mi 
echo ${var%n5}  ---- "%" ----- ayak jagynan "n5" degen dal kelse remove n5

## *********************  awk  ****************************** 
ifconfig | grep "\: " | awk -F ":" '{if ($1 !~ "lo") print $1} ' ------ awk if 
awk '{if($3 != 0) a = ($3/$4) print $0, a; else if($3==0) print $0, "-" }' file > out
cat /var//log/secure | awk '{if ($2 ~ "20") print}' | awk '/Accepted/ {print $11}' --- nurik

realpath file1               ------- /home/mirlan/file1  ----dep full path beret
dirname  /home/mirlan/file1  ------  /home/mirlan  ---- chygat 


# ******************* new syntax arrays *************************

array=(`ls`)

array=("bir" "eki" "uch" 7)    or

declare -a array=("bir" "eki" "uch" 7)

#if [[ " ${array[@]} " =~ " ${value} " ]]; then
if [[ " ${array[@]} " =~ "uch" ]]; then
echo bar  

array+=(8)   # append into array

echo ${array[@]:3}   # prints array starting from 3rd component 


aa=` expr ${#array[@]} - 1`   # count array length and -1  important. ${#a}
echo ${array[$aa]} 
   # whatever you want to do when arr contains value
fi

# ******************* new syntax for if *************************

if grep -q rr test.sh ;then
echo bar eken
fi

# **************** change value of GRUB_DEFAULT **************************

sed  "s/^\(GRUB_DEFAULT=\).*/\1Mirlan/g" grub

sed 's,^\(GRUB_DEFAULT=\).*$,\1mirlan,g' grub   # use ","  instead of  "/"

########################### more sed ################
cat install.log | sed -n '$p'  # -------------- print last line
ls | sed -e '/log$/d'
ls | sed -n '/log$/p'
ls | sed -n '/log$/p' | sed -e '/Summary/d'| xargs cat | grep fail

sed -n '1,4p' #-- 1-4 cheinki line print
sed '1,4d'    #-1-- 1 den 4 ko chein delete
sed '1,4!d'    #-1-- 1 den 4 ko chein don't delete
sed '1,35 s///g' file
sed '5i I am on 5th line' file # isert to 5th line
sed '/Mirlan/a \Tokonbekov'
cat maas_ci.tf | sed '1,5d'
cat maas_ci.tf | sed '/variable/d'

# **************** local  *** is use variable only locally, ignore outside of scope  ***********************

a=7
func (){

local a=5
a=5
echo $a

}

func

echo $a

# ***************************** declare  ***************************


# declare -r a=10   # don't use this messes up the system

echo $a # (get 10)
a="miki"  # (a is read only variable cannot set)
# declare -i x=10
echo $x  # (get 10)
x="miki"
echo $x  # (get 0 ) because you can define only interger (numbers)

# ***********************  type  **** is like "which" *******************

type echo

#echo is a shell builtin
#echo is /bin/echo
#echo is /usr/bin/echo

# chygat  :)

# ************* $? *************************

echo "Mirlan"
echo $?  # 0 chygat means no error

# cp source  no dest  
# 1 chygat      cp source wrong command 


# *********** exit 0,1,2  ***********************     

# exit 0     exit saying everything was corret
# exit 1     exit saying everything was error
# exit 2     exit saying command misuse  error

# ********************fast copy with tar ****************************
tar -cf - emacs.txt |(cd /opt/ ; tar -xvf -) 














