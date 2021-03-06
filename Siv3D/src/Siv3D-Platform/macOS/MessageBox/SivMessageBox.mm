//-----------------------------------------------
//
//	This file is part of the Siv3D Engine.
//
//	Copyright (c) 2008-2019 Ryo Suzuki
//	Copyright (c) 2016-2019 OpenSiv3D Project
//
//	Licensed under the MIT License.
//
//-----------------------------------------------

# include <Siv3D/MessageBox.hpp>
# import <Cocoa/Cocoa.h>

namespace s3d
{
	int ShowMessageBox_macOS(const char* title, const char* message, const int style, const int buttons)
	{
		NSAlert* alert = [[NSAlert alloc] init];
		[alert setMessageText:[NSString stringWithCString:title encoding:NSUTF8StringEncoding]];
		[alert setInformativeText:[NSString stringWithCString:message encoding:NSUTF8StringEncoding]];
		
		const NSAlertStyle styles[] = {
			NSAlertStyleInformational,
			NSAlertStyleInformational,
			NSAlertStyleWarning,
			NSAlertStyleCritical,
			NSAlertStyleInformational,
		};
		[alert setAlertStyle: styles[style]];
		
		switch (buttons)
		{
			case 0:
				[alert addButtonWithTitle: @"OK"];
				break;
			case 1:
				[alert addButtonWithTitle: @"OK"];
				[alert addButtonWithTitle: @"Cancel"];
				break;
			case 2:
				[alert addButtonWithTitle: @"Yes"];
				[alert addButtonWithTitle: @"No"];
				break;
		}
		
		const long resultIndex = [alert runModal];
		[alert release];
		
		switch (buttons)
		{
			case 0:
				return 0;
			case 1:
				return resultIndex == NSAlertFirstButtonReturn ? 0 : 1;
			case 2:
				return resultIndex == NSAlertFirstButtonReturn ? 2 : 3;
			default:
				return 4;
		}
	}
	
	namespace System
	{
		MessageBoxSelection ShowMessageBox(const String& title, const String& text, MessageBoxStyle style, MessageBoxButtons buttons)
		{
			const int32 result = ShowMessageBox_macOS(title.narrow().c_str(), text.narrow().c_str(),
															  static_cast<int32>(style), static_cast<int32>(buttons));
			
			return static_cast<MessageBoxSelection>(result);
		}
	}
}
