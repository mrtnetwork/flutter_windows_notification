const String alarmtTemplate =
    r'''<toast launch="action=viewAlarm&amp;alarmId=3" scenario="alarm">

  <visual>
    <binding template="ToastGeneric">
      <text>Time to wake up!</text>
      <text>To prove you're awake, select which of the following fruits is yellow...</text>
    </binding>
  </visual>

  <actions>

    <input id="answer" type="selection" defaultInput="wrongDefault">
      <selection id="wrong" content="Orange"/>
      <selection id="wrongDefault" content="Blueberry"/>
      <selection id="right" content="Banana"/>
      <selection id="wrong" content="Avacado"/>
      <selection id="wrong" content="Cherry"/>
    </input>

    <action
      activationType="system"
      arguments="snooze"
      content=""/>

    <action
      activationType="background"
      arguments="dismiss"
      content="Dismiss"/>

  </actions>

</toast>
''';
