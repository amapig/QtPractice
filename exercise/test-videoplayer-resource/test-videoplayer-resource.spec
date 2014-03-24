
Name:       test-videoplayer-resource
Summary:    Short description
Version:    0.1.0
Release:    1
Group:      Application
License:    License information
URL:        http://app.url/
# This must remain as is for OBS. Also build script expects this.
Source0:    %{name}-%{version}.tar.gz
# Add required packages, if any.
Requires(post): desktop-file-utils
#Requires(post): shared-mime-info
Requires(postun): desktop-file-utils
#Requires(postun): shared-mime-info
# Add requirements for building. Full info needed for OBS.
#BuildRequires:  pkgconfig(QtGui)
#BuildRequires:  pkgconfig(QtWebKit)
BuildRequires:  gcc-c++
BuildRequires:  desktop-file-utils


%description
Missing description

%prep
%setup -q -n %{name}-%{version}


%build
# Macro has -qt option and qmake does not recognize it.
#qmake5 IDE_LIBRARY_BASENAME=%{_lib}
export QT_SELECT=5
qtchooser -run-tool=qmake -qt=5 -makefile "QMAKE_CFLAGS_RELEASE=${CFLAGS:-%optflags}" "QMAKE_CFLAGS_DEBUG=${CFLAGS:-%optflags}" "QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS:-%optflags}" "QMAKE_CXXFLAGS_DEBUG=${CXXFLAGS:-%optflags}" QMAKE_STRIP=: IDE_LIBRARY_BASENAME=%{_lib}
make %{?jobs:-j%jobs}


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/data/system/applications
# Add mkdir -p for icon directory.
%qmake5_install INSTALL_ROOT=%{buildroot}
# If MIME types are handled, specify the necessary file in sources
# (e.g. Source3:) and uncomment and modify the following:
#mkdir -p %{buildroot}/data/system/mime/packages
#cp -a %{SOURCE3} %{buildroot}/data/system/mime/packages

desktop-file-install --delete-original --dir %{buildroot}/data/system/applications %{buildroot}/data/system/applications/*.desktop


%post
update-desktop-database &> /dev/null || :
#update-mime-database /data/system/mime &> /dev/null || :


%postun
update-desktop-database &> /dev/null || :
#update-mime-database /data/system/mime &> /dev/null || :


%files
%defattr(-,root,root,-)
/data/system
/data/apps


%changelog


