# Automatically generated Makefile. Any changes will be over-written.
# Replacing this will break build/clean unless you know what you are doing.

.PHONY: all
all:
	skytree_make.sh /home/skytree/SDKQt/qt510/ /media/mengcong/workspace/codes/exercise/testMediaPlayer/testMediaPlayer.pro /home/skytree/build-testMediaPlayer-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testMediaPlayer-SDK-Debug

# Delete all except Makefile.
.PHONY: clean
clean:
	find /media/mengcong/workspace/codes/exercise/build-testMediaPlayer-SDK-Debug -mindepth 1 -maxdepth 1 -not -name Makefile -exec rm -rf '{}' \;
	skytree_make.sh /home/skytree/SDKQt/qt510/ /media/mengcong/workspace/codes/exercise/testMediaPlayer/testMediaPlayer.pro /home/skytree/build-testMediaPlayer-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testMediaPlayer-SDK-Debug clean 

# Deploy RPMs.
.PHONY: rpmdeploy
rpmdeploy:
	skytree_rpmdeploy.sh testMediaPlayer /home/skytree/build-testMediaPlayer-SDK-Debug /media/mengcong/workspace/codes/exercise/build-testMediaPlayer-SDK-Debug
