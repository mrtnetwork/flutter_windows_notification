const meetingTemplate =
    r'''<toast launch="action=viewEvent&amp;eventId=1983" scenario="reminder">
  
  <visual>
    <binding template="ToastGeneric">
      <text>Adaptive Tiles Meeting</text>
      <text>Conf Room 2001 / Building 135</text>
      <text>10:00 AM - 10:30 AM</text>
    </binding>
  </visual>

  <actions>
    
    <input id="snoozeTime" type="selection" defaultInput="15">
      <selection id="1" content="1 minute"/>
      <selection id="15" content="15 minutes"/>
      <selection id="60" content="1 hour"/>
      <selection id="240" content="4 hours"/>
      <selection id="1440" content="1 day"/>
    </input>

    <action
      activationType="system"
      arguments="snooze"
      hint-inputId="snoozeTime"
      content=""/>

    <action
      activationType="system"
      arguments="dismiss"
      content=""/>
    
  </actions>
  
</toast>''';
