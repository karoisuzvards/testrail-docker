# testrail

Run [TestRail](http://www.gurock.com/testrail/) in a Docker container, for testing and development.

## Prerequisites

1. Download your version of TestRail from their website, and put it in the current directory (e.g. `testrail-5.6.x-ion53.zip`).
1. Have your TestRail license key ready. You will need it later.

This repository includes a minimal database dump (`testrail.sql`) that can be used as a starting point.
If you want to use your own data, you can dump your existing TestRail database server and replace `data/testrail.sql` with the contents.
See mysql image documentation about data import for more.

## Build the Image

To build the image:

    docker build -t testrail .

## Run the Container 

    docker-compose up

## Usage

Browse to:

    http://localhost:8123/testrail/

To log in:

- Email address: `admin@admin.com`
- Password: `admin`

Problems:
- migrate existing assets (screenshots, reports?) located in same dir where testrail code
