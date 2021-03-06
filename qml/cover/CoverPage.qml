/*
  Copyright (C) 2014 Amilcar Santos
  Contact: Amilcar Santos <amilcar.santos@gmail.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Amilcar Santos nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	Label {
		id: coverLabel
		text: {
			if (isValid()) {
				if (window.currentMarkupText) {
					return window.currentMarkupText;
				} else {
					return window.currentText
				}
			}
			return window.appname
		}

		anchors.fill: parent
		anchors.bottomMargin: Theme.paddingLarge
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		truncationMode: TruncationMode.Fade
		elide: Text.ElideRight

		font.pixelSize: Theme.fontSizeExtraLarge
		font.italic: !isValid()
		color: isValid() ? Theme.secondaryColor : Theme.rgba(Theme.primaryColor, 0.3)

		function isValid() {
			return window.currentText.trim().length > 0
		}
	}
	CoverActionList {
		id: coverAction

		CoverAction {
			iconSource: "image://theme/icon-cover-search"
			onTriggered: {
				window.pop2MainPage()
				var page = pageStack.push(Qt.resolvedUrl("../pages/StoredWordsPage.qml"), '', PageStackAction.Immediate);
				page.textChanged.connect(function() {
					window.forceTextUpdate(window.currentText)
				})
				window.activate();
			}
		}
		CoverAction {
			iconSource: "image://theme/icon-cover-message"
			onTriggered: {
				window.pop2MainPage()
				window.forceTextUpdate('');
				// this should accelerate the virtual keyboard animation
//				window.pageStack.panelSize = window.pageStack.imSize
//				window.pageStack.previousImSize = window.pageStack.imSize
				window.activate();
			}
		}
	}
}
