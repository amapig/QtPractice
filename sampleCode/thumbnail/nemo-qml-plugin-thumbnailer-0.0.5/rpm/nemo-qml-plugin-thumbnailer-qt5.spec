# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.25
# 

Name:       nemo-qml-plugin-thumbnailer-qt5

# >> macros
# << macros

Summary:    Thumbnail provider plugin for Nemo Mobile
Version:    0.0.0
Release:    1
Group:      System/Libraries
License:    BSD
URL:        https://github.com/nemomobile/nemo-qml-plugin-thumbnailer
Source0:    %{name}-%{version}.tar.bz2
Source100:  nemo-qml-plugin-thumbnailer-qt5.yaml
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(gstreamer-0.10)
BuildRequires:  pkgconfig(gstreamer-app-0.10)

%description
%{summary}.

%package video
Summary:    Video thumbnailer provider
Group:      System/Libraries
Requires:   %{name} = %{version}-%{release}

%description video
%{summary}.

%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qmake5

make %{?jobs:-j%jobs}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post


%files
%defattr(-,root,root,-)
%{_libdir}/qt5/qml/org/nemomobile/thumbnailer/libnemothumbnailer.so
%{_libdir}/qt5/qml/org/nemomobile/thumbnailer/qmldir
# >> files
# << files

%files video
%defattr(-,root,root,-)
%{_libdir}/qt5/qml/org/nemomobile/thumbnailer/thumbnailers/libvideothumbnailer.so
# >> files video
# << files video
