Name:           openssl-s_client-enddate-days-json
Summary:        Extracts HTTPS SSL certs enddate and formats as JSON
Version:        0.02
Release:        1%{?dist}
License:        MIT
Group:          System Environment/Daemons
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:	perl(DateTime)
Requires:	perl(DateTime::Format::ISO8601::Format)
Requires:	perl(JSON)
Requires:	/usr/bin/openssl
Requires:	/usr/bin/awk
Requires:	/usr/bin/xargs
Requires:	/usr/bin/date

%description 
Extracts HTTPS SSL certs enddate and formats as JSON

%prep
%setup -q

%build

%install
rm    -rf     $RPM_BUILD_ROOT
mkdir -p      $RPM_BUILD_ROOT%{_bindir}/
cp %{name}.pl $RPM_BUILD_ROOT%{_bindir}/

%files
%defattr(0644,root,root,-)
%attr(0755,root,root) %{_bindir}/%{name}.pl

%clean
rm -rf $RPM_BUILD_ROOT

%changelog
