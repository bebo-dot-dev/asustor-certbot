# Certbot Installation

Asustor unfortunately don't make this easy and there might be a few hurdles that have to be overcome to get certbot installed and working on an Asustor NAS box.

#### Python ####
At the time of writing (this may change again in future) [Certbot is supported on both Python v2.7 and Python v3.6+](https://certbot.eff.org/docs/install.html#system-requirements). This means that at the present time, a Python runtime is a requirement for Certbot. 

Some old model Asustor NAS boxes are stuck on the old and now deprecated Python v2.7 when Python is solely installed from Asustor App Central. If you are in this place and you feel that an upgrade to Python v3.6+ is necessary, it is not an insurmountable problem however getting Python v3.6+ installed will require a manual install of some sort. When manually installing Python v3.6+, ensure that Pip for Python v3.6+ is also installed.

Latest Python builds and compilable code is available from [Python downloads](https://www.python.org/downloads/) 

Another option for installing Python v3.6 might to use the `opkg` package manager which is installable via Asustor App Central by installing the `entware-ng` NAS app.

#### Building Code ####
If you find that either Python code or Certbot code requires compilation for installation, consider these two options:

1. Install the required build tools on the NAS box itself and compile code directly on the NAS box OR
2. Install the required build tools in some environment other than the NAS box, compile code in that environment and transfer built code to the NAS

Generally code compilation will miminally require `gcc` and in some cases other build tools i.e `setuptools`. If opting for option (1) above, `opkg` may help get `gcc` and any other required build toolchain dependencies installed on an Asustor NAS box.

#### Certbot Package Dependencies ####
When Certbot is installed via pip it will pull and install the python packages that it depends on at install time. Some python packages will install successfully in a transparent manner whilst others might fail to install due to requiring code compilation as part of their install and the required toolchain tools not being immediately present. If an installation failure is seen for a given package, getting that package to successfully install requires the analysis of the install and compilation requirements of that package to understand what is missing and what will need to be installed to get that package to compile and install as expected.