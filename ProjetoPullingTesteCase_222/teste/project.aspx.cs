using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net;
using System.Threading.Tasks;
using System.Text;
using System.Net.Http.Headers;
using System.Web.Script.Serialization;
using System.Configuration;
using System.Web.Util;
using Newtonsoft.Json.Linq;

namespace teste
{
    ////*** Coleta lista de times e projetos
    ////GET https://dev.azure.com/{organization}/_apis/teams?api-version=4.1-preview.2
    //string JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/", "_apis/teams?api-version=4.1-preview.2").Result;

    ////*** Coleta lista de iterações
    ////*** GET https://dev.azure.com/{organization}/{project}/{team}/_apis/work/teamsettings/iterations?api-version=4.1
    //JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + e.CommandArgument + "/", "_apis/work/teamsettings/iterations?api-version=4.1").Result;

    ////*** Obtem lista de work items de uma iteração
    ////*** GET https://dev.azure.com/{organization}/{project}/{team}/_apis/work/teamsettings/iterations/{iterationId}/workitems?api-version=4.1-preview.1
    //JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + e.CommandArgument + "/", "_apis/work/teamsettings/iterations/26ab56f3-67b0-409f-ab0d-be7e6f6ab4ef/workitems?api-version=4.1-preview.1").Result;

    ////*** Pergar Work Itens
    ////*** GET https://dev.azure.com/{organization}/{project}/_apis/wit/queries?api-version=4.1 (new)
    ////*** GET https://dev.azure.com/{organization}/{project}/_apis/wit/workitems?id={ids}&api-version=4.1
    //JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + e.CommandArgument + "/" , "_apis/wit/workitems?id=3&api-version=4.1").Result;

    public partial class project : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //*** O operador está conectado?
            if (Session["PullingTesteCase_Login"] != null)
            {
                //*** Recupera dados de login
                LoginData oLogin = (LoginData)Session["PullingTesteCase_Login"];

                //*** O login é válido?
                if (LoginData.ValidateLogin(oLogin.username, oLogin.password) != "Ok")
                {
                    //*** Redireciona ao login
                    Response.Redirect("login.aspx");
                }

                //*** Define funções dos botões
                this.btnOpenProject.ServerClick += new EventHandler(btnOpenProject_Click);
            }
            else
            {
                //*** Redireciona ao login
                Response.Redirect("login.aspx");
            }
        }

        public static async Task<string> GetAzureData(string BaseAddress, string Function)
        {
            //*** Define personal token
            string oCredentials = Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(string.Format("{0}:{1}", "", Properties.Settings.Default.PersonalAccessToken)));

            //*** Define acesso via Proxy
            WebProxy oProxy = Util.GetProxy();
            if (oProxy != null)
                WebRequest.DefaultWebProxy = oProxy;

            //*** Cria objeto de requisição
            HttpClient oHTTPClient = new HttpClient(); http://localhost:49324/Properties/
            oHTTPClient.DefaultRequestHeaders.UserAgent.Add(new ProductInfoHeaderValue("Mozilla", "5.0"));
            oHTTPClient.BaseAddress = new Uri(BaseAddress);
            oHTTPClient.DefaultRequestHeaders.Accept.Clear();
            oHTTPClient.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
            oHTTPClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", oCredentials);

            //*** GET - Conecta ao endpoint (URL) do serviço REST
            using (var oResponse = await oHTTPClient.GetAsync(Function))
            {
                string content = await oResponse.Content.ReadAsStringAsync();
                return content;
            }
        }

        void btnOpenProject_Click(object sender, EventArgs e)
        {
            //*** Coleta lista de times e projetos
            //*** GET https://dev.azure.com/{organization}/_apis/projects?api-version=4.1
            string JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/", "_apis/teams?api-version=4.1-preview.2").Result;

            //*** Desserializa JSON
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            TFS_TeamProjects_List oList = oSerializer.Deserialize<TFS_TeamProjects_List>(JSONStr);

            //*** Realiza bind dos dados com a lista
            this.gvwTeamProjects.DataSource = oList.value;
            this.gvwTeamProjects.DataBind();
        }

        protected void gvwTeamProjects_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            string[] parameters = e.CommandArgument.ToString().Split('|');
            string projectId = parameters[0];
            string teamId = parameters[1];

            //*** Coleta lista de iterations
            //*** GET https://dev.azure.com/{organization}/_apis/projects?api-version=4.1
            string strBaseAdress = "https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/" + teamId + "/";
            string strFunction = "_apis/work/teamsettings/iterations?api-version=4.1";

            string JSONStr = GetAzureData(strBaseAdress, strFunction).Result;

            //*** Desserializa JSON
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            TFS_Iterations_List oList = oSerializer.Deserialize<TFS_Iterations_List>(JSONStr);

            //*** Copia ID do projeto e do team
            for (int index = 0; index < oList.value.Count<TFS_Iterarions>(); index++)
            {
                oList.value[index].projectId = projectId;
                oList.value[index].teamId = teamId;
            }

            //*** Realiza bind dos dados com a lista
            this.gvwIterations.DataSource = oList.value;
            this.gvwIterations.DataBind();
        }

        protected void gvwIterations_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            string[] parameters = e.CommandArgument.ToString().Split('|');
            string projectId = parameters[0];
            string teamId = parameters[1];
            string iterationId = parameters[2];

            //*** Coleta lista de tasks de uma iteration
            //*** GET https://dev.azure.com/{organization}/{project}/{team}/_apis/work/teamsettings/iterations/{iterationId}/workitems?api-version=4.1-preview.1
            string JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/" + teamId + "/", "_apis/work/teamsettings/iterations/" + iterationId + "/workitems?api-version=4.1-preview.1").Result;
            //string JSONStr = GetAzureData("https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/", "_apis/wit/queries?$depth=2&api-version=4.1").Result;

            //*** Desserializa JSON
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            IterationWorkItem oListIterationWorkItem = oSerializer.Deserialize<IterationWorkItem>(JSONStr);

            List<dynamic> objListWorkItem = new List<dynamic>();
            foreach (var item in oListIterationWorkItem.workItemRelations)
            {
                //*** Coleta lista de WorkItem de uma iteration
                //GET https://dev.azure.com/{organization}/{project}/_apis/wit/workitems?ids={ids}&api-version=4.1
                JSONStr = GetAzureData(
                    "https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/",
                    "_apis/wit/workitems?ids=" + item.target.id + "&fields=System.Id,System.Title,System.Description&api-version=4.1").Result;

                WorkItem objWorkItem = oSerializer.Deserialize<WorkItem>(JSONStr);

                objWorkItem.projectId = projectId;
                objWorkItem.teamId = teamId;

                objListWorkItem.Add(new
                {
                    Title = objWorkItem.value[0].fields["System.Title"],
                    Description = objWorkItem.value[0].fields["System.Description"],
                    workItemId = objWorkItem.value[0].fields["System.Id"],
                    projectId = projectId,
                    teamId = teamId
                });
            }

            //*** Realiza bind dos dados com a lista
            this.gdvWorkItem.DataSource = objListWorkItem;
            this.gdvWorkItem.DataBind();
        }

        protected void gvwWorkItem_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            string[] parameters = e.CommandArgument.ToString().Split('|');
            string projectId = parameters[0];
            string teamId = parameters[1];
            string workItemId = parameters[2];

            //GET https://dev.azure.com/{organization}/{project}/_apis/wit/workitems/{id}?fields={fields}&asOf={asOf}&$expand={$expand}&api-version=4.1
            //*** Coleta lista de iterations
            //*** GET https://dev.azure.com/{organization}/_apis/projects?api-version=4.1
            string strBaseAdress = "https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/";
            string strFunction = "_apis/wit/workitems/" + workItemId + "?$expand=all&api-version=4.1";

            string JSONStr = GetAzureData(strBaseAdress, strFunction).Result;

            //*** Desserializa JSON
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            ItemWork oListIterationWorkItem = oSerializer.Deserialize<ItemWork>(JSONStr);

            List<dynamic> objListWorkItem = new List<dynamic>();
            if (oListIterationWorkItem.relations != null)
            {
                foreach (var item in oListIterationWorkItem.relations)
                {
                    string strWorkItemId = oListIterationWorkItem.relations[0].url.Split('/')[7];

                    //*** Coleta lista de WorkItem de uma iteration
                    //GET https://dev.azure.com/{organization}/{project}/_apis/wit/workitems?ids={ids}&api-version=4.1
                    JSONStr = GetAzureData(
                        "https://dev.azure.com/" + Properties.Settings.Default.Organization + "/" + projectId + "/",
                        "_apis/wit/workitems?ids=" + strWorkItemId +
                        "&fields=System.Id,System.Title,System.Description&api-version=4.1").Result;

                    WorkItem objWorkItem = oSerializer.Deserialize<WorkItem>(JSONStr);

                    objWorkItem.projectId = projectId;
                    objWorkItem.teamId = teamId;
                    object description;
                    objWorkItem.value[0].fields.TryGetValue("System.Description", out description);

                    objListWorkItem.Add(new
                    {
                        Title = objWorkItem.value[0].fields["System.Title"],
                        Description = description,
                        workItemId = objWorkItem.value[0].fields["System.Id"],
                        projectId = projectId,
                        teamId = teamId
                    });
                }
            }

            //*** Realiza bind dos dados com a lista
            this.gdvTestCase.DataSource = objListWorkItem;
            this.gdvTestCase.DataBind();
        }

        protected void gdvTestCase_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
    }
}