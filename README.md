# Cutedriver test runner

Enviroment to run functional tests for Qt applications using cuTeDriver, a fork of TDriver from Nomovok, for more info: https://github.com/nomovok-opensource/cutedriver-agent_qt/wiki

## How to run tests

Lets suppose you have a functional test file called `test.rb` that you want to execute into your target device with IP `10.4.4.224` which is running `qttasserver`.

In order to run the test you need to create your `parameters.xml` file indicating the ip address of the remote device.

```
<parameters>
	<sut id="sut_qt" template="qt">
		<!-- ip address of the device to test -->
		<parameter name="qttas_server_ip" value="10.4.4.224" />
	</sut>

	<parameter name="behaviours" value="behaviours.xml"/>
</parameters>
```

Then you can run your test script with:
```
docker run -t -i --rm -p 55535:55535 -v $(pwd)/parameters.xml:/etc/tdriver/tdriver_parameters.xml -v $(pwd)/test.rb:/root/test.rb rferrazz/cutedriver test.rb
```
