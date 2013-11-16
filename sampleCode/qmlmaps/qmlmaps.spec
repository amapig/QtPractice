Name:           qmlmaps
Version:    0.1.7
Release:        1.1.Nemo
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

%changelog
* Mon Apr 22 2013 John Brooks <john.brooks@dereferenced.net> - 0.1.7
- [qmlmaps] Correctly link to qdeclarative-boostable
- [qmlmaps] Update packaging
* Mon Sep 10 2012 Marko Saukko <marko.saukko@jollamobile.com> - 0.1.6
- Drop %%{?_isa} from dependency
* Tue Feb 21 2012 Marko Saukko <marko.saukko@gmail.com> - 0.1.6
- Added dependency to qt-components
* Thu Dec  1 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.6
- Flicker free
* Fri Nov 18 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.5
- Boosted P and L
* Fri Nov 11 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.4
- Boosted ARM version for real, splash images
* Fri Oct 14 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.3
- Boosted ARM version, normal x86 version
* Thu Oct  6 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.2
- Fullscreen mode and packaging changes
* Wed Oct  5 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.1.1
- fixin binary name
* Wed Oct  5 2011 Jakub Pavelek <jpavelek@live.com> - 0.1.1
- adding desktop file
* Tue Sep 27 2011 Jakub Pavelek <jpavelek@live.com> - 0.1
- first RPM packaging release
