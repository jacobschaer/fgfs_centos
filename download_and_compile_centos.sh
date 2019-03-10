sudo yum-complete-transaction -y
sudo yum update -y
sudo yum install -y epel-release
sudo yum update -y
sudo yum install -y gcc gcc-c++ make cmake git libcurl-devel libarchive-devel bzip2-devel expat-devel xz-devel ncurses-devel procps zlib-devel  libtiff-devel qt-devel freeglut-devel boost-devel  libgudev1-devel libudev-devel dbus-devel libpng-devel  libXi-devel libXmu-devel libXinerama-devel libjpeg-turbo-devel libXft-devel tkinter cmake3 jsoncpp-devel gdal-devel glew-devel openal-soft-devel fltk-fluid python34 python34-tkinter


WORKSPACE_PATH="/home/jacob/Desktop/fgfs"

#CMake
CMAKE_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/cmake
CMAKE_INSTALL_PATH=$WORKSPACE_PATH/install/cmake
CMAKE_BUILD_PATH=$WORKSPACE_PATH/build/cmake
mkdir -p $CMAKE_CHECKOUT_PATH
mkdir -p $CMAKE_INSTALL_PATH
git clone http://cmake.org/cmake.git $CMAKE_CHECKOUT_PATH
cd $CMAKE_CHECKOUT_PATH
git pull -r
git checkout -f master
cd $CMAKE_BUILD_PATH
$CMAKE_CHECKOUT_PATH/cmake/configure --prefix="$CMAKE_INSTALL_PATH"
make
make install

# Configure to use custom CMAKE
export CMAKE=$CMAKE_INSTALL_PATH/bin/cmake

#GCC
GCC_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/gcc
GCC_INSTALL_PATH=$WORKSPACE_PATH/install/gcc
mkdir -p $GCC_CHECKOUT_PATH
mkdir -p $GCC_INSTALL_PATH
wget https://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2 -O $GCC_CHECKOUT_PATH/gcc.tar.gz2
cd $GCC_CHECKOUT_PATH
tar -xvvf gcc.tar.gz2
cd gcc-4.9.4
sudo yum install -y libmpc-devel mpfr-devel gmp-devel
./configure --disable-multilib
make
make DESTDIR=$GCC_INSTALL_PATH install

# Setup environment to use GCC 4.9.4 - anything pre 4.8 either fails outright or segfaults at some point
export CC=$GCC_INSTALL_PATH/usr/local/bin/gcc
export CXX=$GCC_INSTALL_PATH/usr/local/bin/g++

#CURL
CURL_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/curl
CURL_BUILD_PATH=$WORKSPACE_PATH/build/curl
CURL_INSTALL_PATH=$WORKSPACE_PATH/install/curl
mkdir -p $CURL_CHECKOUT_PATH
mkdir -p $CURL_INSTALL_PATH
mkdir -p $CURL_BUILD_PATH
git clone https://github.com/curl/curl.git $CURL_CHECKOUT_PATH
cd $CURL_CHECKOUT_PATH
git pull -r
git checkout -f curl-7_64_0
cd $CURL_BUILD_PATH
cmake3 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$CURL_INSTALL_PATH $CURL_CHECKOUT_PATH


#BOOST
BOOST_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/boost
BOOST_BUILD_PATH=$WORKSPACE_PATH/build/boost
BOOST_INSTALL_PATH=$WORKSPACE_PATH/install/boost
mkdir -p $BOOST_CHECKOUT_PATH
mkdir -p $BOOST_INSTALL_PATH
mkdir -p $BOOST_BUILD_PATH
wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz -O $BOOST_CHECKOUT_PATH/boost.tar.gz
cd $BOOST_CHECKOUT_PATH
tar -xvvf boost.tar.gz 
cd $BOOST_CHECKOUT_PATH/boost_1_69_0/
cd tools/build
sh bootstrap.sh  --prefix=$BOOST_INSTALL_PATH
echo "using gcc : 4.9.4 : $CXX ; " >> src/user-config.jam
cd $BOOST_CHECKOUT_PATH/boost_1_69_0/
tools/build/b2 --prefix=$BOOST_INSTALL_DIR --build-dir=$BOOST_BUILD_DIR toolset=gcc-4.9.4 install
export $PATH=$BOOST_BUILD_DIR/boost:$PATH

# Diretrions for older LibCURL
#./configure --prefix=$CURL_INSTALL_PATH
#make
#make install

# OpenAL
# ??

# Zlib
ZLIB_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/zlib
ZLIB_INSTALL_PATH=$WORKSPACE_PATH/install/zlib
ZLIB_BUILD_PATH=$WORKSPACE_PATH/build/zlib
mkdir -p $ZLIB_CHECKOUT_PATH
mkdir -p $ZLIB_INSTALL_PATH
mkdir -p $ZLIB_BUILD_PATH
wget https://www.zlib.net/zlib-1.2.11.tar.gz -O $ZLIB_CHECKOUT_PATH/zlib.tar.gz
cd $ZLIB_CHECKOUT_PATH
tar -xvvf zlib.tar.gz 
cd $ZLIB_CHECKOUT_PATH/zlib-1.2.11/
./configure
make
make install prefix=$ZLIB_INSTALL_PATH

# OpenScene Graph
OSG_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/openscenegraph
OSG_INSTALL_PATH=$WORKSPACE_PATH/install/openscenegraph
OSG_BUILD_PATH=$WORKSPACE_PATH/build/openscenegraph
mkdir -p $OSG_CHECKOUT_PATH
mkdir -p $OSG_INSTALL_PATH
mkdir -p $OSG_BUILD_PATH
git clone https://github.com/openscenegraph/osg.git $OSG_CHECKOUT_PATH
cd $OSG_CHECKOUT_PATH
git pull -r
git checkout -f OpenSceneGraph-3.4
cd $OSG_BUILD_PATH
cmake3 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$OSG_INSTALL_PATH $OSG_CHECKOUT_PATH
make
make install

#Plib
PLIB_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/plib
PLIB_INSTALL_PATH=$WORKSPACE_PATH/install/plib
PLIB_BUILD_PATH=$WORKSPACE_PATH/build/plib
mkdir -p $PLIB_CHECKOUT_PATH
mkdir -p $PLIB_INSTALL_PATH
mkdir -p $PLIB_BUILD_PATH
git clone https://git.code.sf.net/p/libplib/code $PLIB_CHECKOUT_PATH
cd $PLIB_CHECKOUT_PATH
git pull -r
git checkout -f master
cd $PLIG_BUILD_PATH
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=$PLIB_INSTALL_PATH $PLIB_CHECKOUT_PATH
make
make install

#OpenRTI
OPENRTI_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/openrti
OPENRTI_INSTALL_PATH=$WORKSPACE_PATH/install/openrti
OPENRTI_BUILD_PATH=$WORKSPACE_PATH/build/openrti
mkdir -p $OPENRTI_CHECKOUT_PATH
mkdir -p $OPENRTI_INSTALL_PATH
mkdir -p $OPENRTI_BUILD_PATH
git clone https://git.code.sf.net/p/openrti/OpenRTI $OPENRTI_CHECKOUT_PATH
cd $OPENRTI_CHECKOUT_PATH
git pull -r
git checkout -f master
cd $OPENRTI_BUILD_PATH
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=$OPENRTI_INSTALL_PATH $OPENRTI_CHECKOUT_PATH
make
make install

# SimGear
SIMGEAR_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/simgear
SIMGEAR_INSTALL_PATH=$WORKSPACE_PATH/install/simgear
SIMGEAR_BUILD_PATH=$WORKSPACE_PATH/build/simgear
mkdir -p $SIMGEAR_CHECKOUT_PATH
mkdir -p $SIMGEAR_INSTALL_PATH
mkdir -p $SIMGEAR_BUILD_PATH
git clone https://git.code.sf.net/p/flightgear/simgear $SIMGEAR_CHECKOUT_PATH
cd $SIMGEAR_CHECKOUT_PATH
git pull -r
git checkout -f next
cd $SIMGEAR_BUILD_PATH
cmake3 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=$SIMGEAR_INSTALL_PATH -DCMAKE_PREFIX_PATH="$BOOST_INSTALL_PATH;$OSG_INSTALL_PATH;$OPENRTI_INSTALL_PATH;$ZLIB_INSTALL_PATH;$CURL_INSTALL_PATH" $SIMGEAR_CHECKOUT_PATH
make
make install

#QT5
sudo yum install -y libxcb libxcb-devel xcb-util xcb-util-devel
QT5_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/qt5
QT5_INSTALL_PATH=$WORKSPACE_PATH/install/qt5
QT5_BUILD_PATH=$WORKSPACE_PATH/build/qt5
mkdir -p $QT5_CHECKOUT_PATH
mkdir -p $QT5_INSTALL_PATH
mkdir -p $QT5_BUILD_PATH
git clone git://code.qt.io/qt/qt5.git $QT5_CHECKOUT_PATH
cd $QT5_CHECKOUT_PATH
git checkout 5.12
perl init-repository --module-subset=default,-qtwebengine
./configure -developer-build -opensource -nomake examples -nomake tests --confirm-license
gmake
gmake install

# FGFS
FLIGHTGEAR_CHECKOUT_PATH=$WORKSPACE_PATH/checkouts/flightgear
FLIGHTGEAR_INSTALL_PATH=$WORKSPACE_PATH/install/flightgear
FLIGHTGEAR_BUILD_PATH=$WORKSPACE_PATH/build/flightgear
FGDATA_INSTALL_PATH=$FLIGHTGEAR_INSTALL_PATH/fgdata
mkdir -p $FLIGHTGEAR_CHECKOUT_PATH
mkdir -p $FLIGHTGEAR_INSTALL_PATH
mkdir -p $FLIGHTGEAR_BUILD_PATH
mkdir -p $FGDATA_INSTALL_PATH
git clone https://git.code.sf.net/p/flightgear/flightgear $FLIGHTGEAR_CHECKOUT_PATH
cd $FLIGHTGEAR_CHECKOUT_PATH
git pull -r
git clone https://git.code.sf.net/p/flightgear/fgdata $FGDATA_INSTALL_PATH
cd $FGDATA_INSTALL_PATH
git pull -r
cd $FLIGHTGEAR_BUILD_PATH
cmake3 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=$FLIGHTGEAR_INSTALL_PATH -DCMAKE_PREFIX_PATH="$BOOST_INSTALL_PATH;$QT5_INSTALL_PATH;$SIMGEAR_INSTALL_PATH;$OSG_INSTALL_PATH;$OPENRTI_INSTALL_PATH;$ZLIB_INSTALL_PATH;$CURL_INSTALL_PATH" -DFG_DATA_DIR="$FGDATA_INSTALL_PATH" $FLIGHTGEAR_CHECKOUT_PATH
make
make install


# libcgal-devel libqt4-dev zlib1g-devel freeglut3-devel libopenscenegraph-3.4-devel libopenscenegraph-devel  libplib-dev  libpng12-devel libpng16-dev qt5-default qtdeclarative5-dev qtbase5-dev-tools qttools5-dev-tools qml-module-qtquick2 qml-module-qttquick-window2 qml-module-qtquick-dialogs libqt5opengl5-devel libqt5svt5-devel libqt5websockets5-devel qtbase5-private-devel qtdeclarative5-private-devel  fluid python3-pyqt5 python3-pyqt5.qtmultimedia libqt5multimedia5-plugins python-tk

