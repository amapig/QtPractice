%define debug_packages %{nil}
%define debug_package %{nil}
Name:		cmosmusics
Version:	1.0.2
Release:	1
Summary:	music

Group:		Applicaton/MultiMedia
License:	GPL
URL:		www.test.com
Source0:	%{name}-%{version}.tar.gz		
BuildRoot:	%{_tmppath}/%{name}-root

%description
cmos music

%prep
%setup -q

%build
qmake
make

%install
make INSTALL_ROOT=%{buildroot} install

%clean

%files
%defattr(-,root,root,-)
/*
%changelog
