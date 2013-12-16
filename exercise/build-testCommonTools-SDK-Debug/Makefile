# Automatically generated Makefile. Any changes will be over-written.
# Replacing this will break build/clean unless you know what you are doing.

.PHONY: all
all:
	skytree_make.sh /home/skytree/SDKQt/qt510/ /media/mengcong/workspace/codes/exercise/testCommonTools/testCommonTools.pro /home/skytree/build-testCommonTools-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testCommonTools-SDK-Debug

# Delete all except Makefile.
.PHONY: clean
clean:
	find /media/mengcong/workspace/codes/exercise/build-testCommonTools-SDK-Debug -mindepth 1 -maxdepth 1 -not -name Makefile -exec rm -rf '{}' \;
	skytree_make.sh /home/skytree/SDKQt/qt510/ /media/mengcong/workspace/codes/exercise/testCommonTools/testCommonTools.pro /home/skytree/build-testCommonTools-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testCommonTools-SDK-Debug clean 

# Deploy RPMs.
.PHONY: rpmdeploy
rpmdeploy:
	skytree_rpmdeploy.sh testCommonTools /home/skytree/build-testCommonTools-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testCommonTools-SDK-Debug
