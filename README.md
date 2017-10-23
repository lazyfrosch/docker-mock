Mock in Docker
==============

## Usage

Pull the image from Docker Hub

    docker pull lazyfrosch/mock

Have a look on the helper script `mock.example.sh` here and modify it to your needs.

    vim mock.example.sh
    cp mock.example.sh $HOME/bin/mock
    chmod +x $HOME/bin/mock

Then you can run mock like it would be installed locally.

## Important notes

About the helper script.

* For correct permissions to work the helper script uses your UID and GID to write files
* The helper script mounts your HOME directory to the container
* Put the build/cache dirs to a volume or persistent location on your host

## License

    Copyright 2017 Markus Frosch <markus@lazyfrosch.de>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
