using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace teste
{
    #region [: TFS - Lista Team Projects :]

    public class TFS_TeamProjects
    {
        public string id { get; set; }
        public string name { get; set; }
        public string url { get; set; }
        public string description { get; set; }
        public string identityUrl { get; set; }
        public string projectName { get; set; }
        public string projectId { get; set; }
        public string state { get; set; }
        public string revision { get; set; }
        public string visibility { get; set; }

        public TFS_TeamProjects()
        {
            string id = string.Empty;
            string name = string.Empty;
            string url = string.Empty;
            string description = string.Empty;
            string identityUrl = string.Empty;
            string projectName = string.Empty;
            string projectId = string.Empty;
            string state = string.Empty;
            string revision = string.Empty;
            string visibility = string.Empty;
        }
    }

    public class TFS_TeamProjects_List
    {
        public int count { get; set; }
        public TFS_TeamProjects[] value { get; set; }

        public TFS_TeamProjects_List()
        {
            count = 0;
            value = null;
        }
    }

    #endregion

    #region [: TFS - Iterations :]

    public class TFS_Iterarions
    {
        public string name { get; set; }
        public string path { get; set; }
        public TFS_Iterarion_Attributes attributes { get; set; }
        public string url { get; set; }
        public string projectId { get; set; }
        public string teamId { get; set; }
        public string id { get; set; } //*** Iteration ID

        public TFS_Iterarions()
        {
            name = string.Empty;
            path = string.Empty;
            attributes = new TFS_Iterarion_Attributes();
            url = string.Empty;
            projectId = string.Empty;
            teamId = string.Empty;
            id = string.Empty;
        }
    }

    public class TFS_Iterarion_Attributes
    {
        public string startDate { get; set; }
        public string finishDate { get; set; }
        public string timeFrame { get; set; }

        public TFS_Iterarion_Attributes()
        {
            startDate = string.Empty;
            finishDate = string.Empty;
            timeFrame = string.Empty;
        }
    }
    public class TFS_Iterations_List
    {
        public int count { get; set; }
        public TFS_Iterarions[] value { get; set; }

        public TFS_Iterations_List()
        {
            count = 0;
            value = null;
        }
    }

    #endregion

    #region [: UTIL - Rotinas de uso geral :]

    public class Util
    {
        public static WebProxy GetProxy()
        {
            //*** A conexão via PROXY está ativa?
            if (Properties.Settings.Default.ProxyActive == true)
            {
                //*** Devolve WEBPROXY montado
                WebProxy oProxy = new WebProxy(Properties.Settings.Default.ProxyAddress, true);
                oProxy.Credentials = new NetworkCredential(Properties.Settings.Default.ProxyUser, Properties.Settings.Default.ProxyPass);
                return oProxy;
            }
            else
            {
                //*** Retorna NULO
                return null;
            }
        }
    }

    #endregion

    #region Iteration Work Item

    public class IterationWorkItem
    {
        public Workitemrelation[] workItemRelations { get; set; }
        public string url { get; set; }
        public _Links _links { get; set; }


    }

    public class _Links
    {
        public Self self { get; set; }
        public Project project { get; set; }
        public Team team { get; set; }
        public Teamiteration teamIteration { get; set; }
    }

    public class Self
    {
        public string href { get; set; }
    }

    public class Project
    {
        public string href { get; set; }
    }

    public class Team
    {
        public string href { get; set; }
    }

    public class Teamiteration
    {
        public string href { get; set; }
    }

    public class Workitemrelation
    {
        public object rel { get; set; }
        public object source { get; set; }
        public Target target { get; set; }
    }

    public class Target
    {
        public int id { get; set; }
        public string url { get; set; }
    }

    #endregion

    #region Work Item

    public class WorkItem
    {
        public int count { get; set; }

        public Value[] value { get; set; }

        public string projectId { get; set; }

        public string teamId { get; set; }
    }

    public class Value
    {
        public int id { get; set; }

        public Dictionary<string, object> fields { get; set; }

        public Relation[] relations { get; set; }

        public _Links _links { get; set; }

        public string url { get; set; }

    }

    public class Fields
    {
        [JsonProperty("Id")]
        public int Id { get; set; }
        public int SystemAreaId { get; set; }
        public string SystemAreaPath { get; set; }
        public string SystemTeamProject { get; set; }
        public string SystemNodeName { get; set; }
        public string SystemAreaLevel1 { get; set; }
        public int SystemRev { get; set; }
        public DateTime SystemAuthorizedDate { get; set; }
        public DateTime SystemRevisedDate { get; set; }
        public int SystemIterationId { get; set; }
        public string SystemIterationPath { get; set; }
        public string SystemIterationLevel1 { get; set; }
        public string SystemIterationLevel2 { get; set; }
        public string SystemWorkItemType { get; set; }
        public string SystemState { get; set; }
        public string SystemReason { get; set; }
        public string SystemAssignedTo { get; set; }
        public DateTime SystemCreatedDate { get; set; }
        public string SystemCreatedBy { get; set; }
        public DateTime SystemChangedDate { get; set; }
        public string SystemChangedBy { get; set; }
        public string SystemAuthorizedAs { get; set; }
        public int SystemPersonId { get; set; }
        public int SystemWatermark { get; set; }
        public int SystemCommentCount { get; set; }
        public string Title { get; set; }
        public DateTime MicrosoftVSTSCommonStateChangeDate { get; set; }
        public int MicrosoftVSTSCommonPriority { get; set; }
        public string MicrosoftVSTSCommonTriage { get; set; }
        public string MicrosoftVSTSCMMIBlocked { get; set; }
        public string MicrosoftVSTSCMMITaskType { get; set; }
        public string MicrosoftVSTSCMMIRequiresReview { get; set; }
        public string MicrosoftVSTSCMMIRequiresTest { get; set; }
        public string Description { get; set; }
    }

    //public class _Links
    //{
    //    public Self self { get; set; }
    //    public Workitemupdates workItemUpdates { get; set; }
    //    public Workitemrevisions workItemRevisions { get; set; }
    //    public Workitemhistory workItemHistory { get; set; }
    //    public Html html { get; set; }
    //    public Workitemtype workItemType { get; set; }
    //    public Fields1 fields { get; set; }
    //}

    //public class Self
    //{
    //    public string href { get; set; }
    //}

    public class Workitemupdates
    {
        public string href { get; set; }
    }

    public class Workitemrevisions
    {
        public string href { get; set; }
    }

    public class Workitemhistory
    {
        public string href { get; set; }
    }

    public class Html
    {
        public string href { get; set; }
    }

    public class Workitemtype
    {
        public string href { get; set; }
    }

    public class Fields1
    {
        public string href { get; set; }
    }

    public class Relation
    {
        public string rel { get; set; }
        public string url { get; set; }
        public Attributes attributes { get; set; }
    }

    public class Attributes
    {
        public bool isLocked { get; set; }
    }

    #endregion

    #region Casos de Teste


    public class ItemWork
    {
        public int id { get; set; }
        public int rev { get; set; }
        public RelationWorkItem[] relations { get; set; }
        public string url { get; set; }
    }

    public class RelationWorkItem
    {
        public string rel { get; set; }
        public string url { get; set; }
        public Attributes attributes { get; set; }
    }

    #endregion
}