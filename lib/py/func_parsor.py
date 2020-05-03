import json
import sys

class HeroFuncParsor:

    # ==================================================
    # START OF HERO FUNC DEF
    # ==================================================

    def func__getAccInfo(self, isToEndCli, inputParamsDict, outputDataDict):
        print("[email]: " + outputDataDict["email"])
        print()
        print("[alias]: " + outputDataDict["alias"])
        print()
        # print(outputDataDict["full_name"]) # no support now
        # print(outputDataDict["job_title"]) # no support now
        # print(outputDataDict["phone"]) # no support now
        print("[about me]: " + outputDataDict["about_me"])
        if inputParamsDict["with_photo"] is not 0:
            print()
            print("[photo]: " + outputDataDict["photo_base64_str"])
        
    def func__stop(self, isToEndCli, inputParamsDict, outputDataDict):
        print() # yes, print nothing, just stop

    def func__logout(self, isToEndCli, inputParamsDict, outputDataDict):
        print(outputDataDict["logout_state_str"])

    def func__getCurrentLoginAcc(self, isToEndCli, inputParamsDict, outputDataDict):
        print(outputDataDict["login_acc_str"])

    def func__login(self, isToEndCli, inputParamsDict, outputDataDict):
        if isToEndCli:
            print(outputDataDict["login_state_str"])
        else:
            print(outputDataDict["login_state_str"], file=sys.stderr)

    def func__getHeroVersion(self, isToEndCli, inputParamsDict, outputDataDict):
        print(outputDataDict["bloonVersionName"])

    def func__echo(self, isToEndCli, inputParamsDict, outputDataDict):
        print(outputDataDict["echo_str"])


    # ==================================================
    # END OF HERO FUNC DEF
    # ==================================================

    def __init__(self):
        pass

    def inputJsonCreator(self, funcName, paramsJsonObjStr):
        paramsDict = json.loads(paramsJsonObjStr)
        inputDict = {
            "func_name": funcName,
            "cbid": "...",
            "params": paramsDict
        }
        inputJsonStr = json.dumps(inputDict)
        return inputJsonStr

    # return boolean: To end cli one time call or not
    def parseFuncOutput(self, outputJsonObjStr):
        # print("outputJsonObjStr: ", str(outputJsonObjStr), file=sys.stderr) # debug only
        outputDict = json.loads(outputJsonObjStr)
        funcName = outputDict["func_name"]
        stateStr = outputDict["output_state"]
        inputParamsDict = outputDict["params"]
        outputDataDict = outputDict["output_data"]
        
        isToEndCli = stateStr == "END_OF_FUNC"
        getattr(self, "func__" + funcName)(isToEndCli, inputParamsDict, outputDataDict)

        return isToEndCli
        
