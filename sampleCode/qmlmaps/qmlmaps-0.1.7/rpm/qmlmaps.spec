Name:           qmlmaps
Version:        0.1.7
Release:        1
Summary:        Simple and fast maps application for QML. Needs data connection!
Group:          User Interface/Desktops
License:        GPL v2
URL:            https://github.com/nemomobile/qmlmaps
Source0:        %{name}-%{version}.tar.bz2
Requires:       qt-components
Requires:       libdeclarative-location
BuildRequires:  pkgconfig(QtCore)
BuildRequires:  pkgconfig(QtGui)
BuildRequires:  pkgconfig(QtDeclarative)
BuildRequires:  pkgconfig(qdeclarative-boostable)
Obsoletes:      meego-handset-maps < 0.1.7
Provides:       meego-handset-maps >= 0.1.7

%description
QML Maps - simple and fast maps application. Uses QtMObility and thus needs data connection to function.

%prep
%setup -q -n %{name}-%{version}

%build
%qmake
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/bin/
install -m 755 bin/meego-handset-maps %{buildroot}/usr/bin/
mkdir -p %{buildroot}/usr/share/applications/
install -m 644 src/data/meego-handset-maps.desktop %{buildroot}/usr/share/applications/
mkdir -p %{buildroot}/usr/share/pixmaps/
install -m 644 src/data/meego-handset-maps-splash-l-800x480.png %{buildroot}/usr/share/pixmaps/
install -m 644 src/data/meego-handset-maps-splash-p-800x480.png %{buildroot}/usr/share/pixmaps/

%files
%defattr(-,root,root,-)
/usr/bin/meego-handset-maps
/usr/share/applications/meego-handset-maps.desktop
/usr/share/pixmaps/meego-handset-maps-splash-l-800x480.png
/usr/share/pixmaps/meego-handset-maps-splash-p-800x480.png

