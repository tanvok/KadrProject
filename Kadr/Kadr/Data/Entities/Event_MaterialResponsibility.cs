﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Controllers;

namespace Kadr.Data
{
    public partial class Event_MaterialResponsibility
    {
        public Event_MaterialResponsibility(UIX.Commands.ICommandManager commandManager, FactStaff fsStaff, EventType eType, MaterialResponsibility mResp = null, Prikaz prEnd = null, DateTime? endTime = null)
            : this()
        {
            var withContract = (prEnd == null);
            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<Event_MaterialResponsibility, Event>(this, "Event",
                new Event(commandManager, fsStaff.CurrentChange, MagicNumberController.MatResponsibilityKind, eType, withContract, null, null), null), this);
            

            if (prEnd == null) return;
            commandManager.Execute(
                new UIX.Commands.GenericPropertyCommand<Event, Prikaz>(this.Event, "Prikaz",
                    prEnd, null), this);
            //возможно, нужно:
            //new UIX.Commands.GenericPropertyCommand<Event, Prikaz>(this.Event, "PrikazEnd",

            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<Event, DateTime?>(this.Event, "DateBegin", endTime, null), this);
            // возможно, нужно:
            //commandManager.Execute(new UIX.Commands.GenericPropertyCommand<Event, DateTime?>(this.Event, "DateEnd", endTime, null), this);

        }
    }
}
