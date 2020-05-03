import asyncio
import websockets
import sys
import json
from func_parsor import HeroFuncParsor
import traceback

class HeroConnector:

    def __init__(self):
        self.fp = HeroFuncParsor()
        self.url = "ws://127.0.0.1:52811"

    async def __async__one_time_hero_func_call(self, inputJsonStr):
        
        async with websockets.connect(self.url) as conn:
            await conn.send(inputJsonStr)
            toEnd = False
            while not toEnd:
                outputJsonStr = await conn.recv()
                # print("outputJsonStr: ", str(outputJsonStr), file=sys.stderr) # for debug only
                toEnd = self.fp.parseFuncOutput(outputJsonStr) # return boolean: To end cli one time call or not

    def one_time_hero_func_call(self, funcName, paramsJsonObjStr):
        inputJsonStr = self.fp.inputJsonCreator(funcName, paramsJsonObjStr)
        # print("inputJsonStr: ", str(inputJsonStr), file=sys.stderr) # for debug only
        return asyncio.get_event_loop().run_until_complete(self.__async__one_time_hero_func_call(inputJsonStr))

if __name__ == '__main__':
    try:
        hc = HeroConnector()
        hc.one_time_hero_func_call(sys.argv[1], sys.argv[2])
        
    except ConnectionRefusedError:
        print("__ConnectionRefusedError__")

    except Exception as ex:
        print("hero_connector ERROR: [", sys.exc_info()[0], "]")
        print("hero_connector ERROR: [", sys.exc_info()[0], "]", file=sys.stderr)
        traceback.print_tb(ex.__traceback__)
