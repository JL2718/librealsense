include(include.pri)

TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt
QMAKE_CXXFLAGS += -std=c++11 -g
QMAKE_CXXFLAGS += -D_FORTIFY_SOURCE=2 -fstack-protector-strong -Wformat -Wformat-security
QMAKE_CXXFLAGS += -z noexecstack -z relro -z now
QMAKE_CXXFLAGS_RELEASE *= -Ofast
PKGCONFIG += glfw3 gl glu libusb-1.0 pcl
CONFIG += link_pkgconfig
INCLUDEPATH += ../include
LIBS += -pthread

SOURCES += ../examples/my-cpp-multipcl.cpp

LIBS += -L$$DESTDIR/ -lrealsense

PRE_TARGETDEPS += $$DESTDIR/librealsense.a

# includes
INCLUDEPATH += "/usr/include/eigen3/" \
"/usr/include/pcl-1.7/" \
"/usr/include/vtk-5.8/" \
"/usr/include/boost/" \
"/usr/include/flann/" \
"/usr/include/openni/" \

# libs
LIBS += -lQtGui -lQtCore -lQtOpenGL \
        -lpcl_registration -lpcl_sample_consensus -lpcl_features -lpcl_filters -lpcl_surface -lpcl_segmentation \
        -lpcl_search -lpcl_range_image -lpcl_kdtree -lpcl_octree -lflann_cpp -lpcl_common -lpcl_io \
        -lpcl_visualization \
        -L/usr/lib -lvtkCommon -lvtksys -lQVTK -lvtkQtChart -lvtkViews -lvtkWidgets -lvtkRendering -lvtkGraphics -lvtkImaging -lvtkIO -lvtkFiltering -lvtkDICOMParser -lvtkmetaio -lvtkexoIIc -lvtkftgl -lvtkHybrid \
 -L/usr/lib -lboost_thread \
