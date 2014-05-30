#!/bin/bash


export BASE_DIR=`pwd`
export SRC_DIR=${BASE_DIR}/src
export INSTALL_DIR=${BASE_DIR}/install

mkdir -p $SRC_DIR
mkdir -p $INSTALL_DIR

export PATH=${INSTALL_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}

cd $SRC_DIR
echo "Source dir ---> $SRC_DIR"
echo "Base dir ----> $BASE_DIR"

if [ -d ${SRC_DIR}/tcl8.5.15 ]; then
	echo "Skip ${SRC_DIR}/tcl8.5.15"
else
	#download tcl
	wget http://prdownloads.sourceforge.net/tcl/tcl8.5.15-src.tar.gz
	#unpack
	tar xvzf  tcl8.5.15-src.tar.gz
	#configure,make,install
	cd ${SRC_DIR}/tcl8.5.15/unix
	./configure --prefix=$INSTALL_DIR --exec-prefix=$INSTALL_DIR
	make 
	make install
fi

if [ -d ${SRC_DIR}/tk8.5.15 ]; then
	echo "Skip ${SRC_DIR}/tk8.5.15"
else
	#doenload tk
	wget http://prdownloads.sourceforge.net/tcl/tk8.5.15-src.tar.gz
	tar xvzf  tk8.5.15-src.tar.gz
	cd ${SRC_DIR}/tk8.5.15/unix
	./configure --prefix=$INSTALL_DIR --exec-prefix=$INSTALL_DIR --with-tcl=${SRC_DIR}/tcl8.5.15/unix
	make 
	make install
fi

if [ -d ${SRC_DIR}/Python-2.7.6 ]; then
	echo "Skip ${SRC_DIR}/Python-2.7.6"
else
        if [ -s ${SRC_DIR}/Python-2.7.6.tgz ]; then
	     echo "Skip download of ${SRC_DIR}/Python-2.7.6.tgz"
        else
	     #download python
	     wget --no-check-certificate http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
        fi
	tar -xzf Python-2.7.6.tgz
	cd ${SRC_DIR}/Python-2.7.6
        ./configure  --with-tcltk-includes=${INSTALL_DIR}/include --with-tcltk-libs=${INSTALL_DIR}/lib
	make 
	make install
fi
python -c "import Tkinter; a=Tkinter.Tk(); print 'fontsystem-->',a.call('::tk::pkgconfig'.'get','fontsystem'); import tkFont; printtkFont.families(); Tkinter._test()"

