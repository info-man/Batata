using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MASTERSEGUROS.WEB.Comum
{
    public class MarcacaoFerias
    {
        private Guid userid	;
        private Int32 periodoid;
        private DateTime data;
        private int estadomarcacaoid;


        public MarcacaoFerias(Guid UserId, Int32 PeriodoId, DateTime Data, int EstadoMarcacaoId)
        {
            this.userid = UserId;
            this.periodoid = PeriodoId;
            this.data = Data;
            this.estadomarcacaoid= EstadoMarcacaoId;
        }

        public Guid UserId
        {
            get
            {
                return userid;
            }
            set
            {
                userid = value;
            }
        }

        public Int32 PeriodoId
        {
            get
            {
                return periodoid;
            }
            set
            {
                periodoid = value;
            }
        }

        public DateTime Data
        {
            get
            {
                return data;
            }
            set
            {
                data = value;
            }
        }

        public Int32 EstadoMarcacaoId
        {
            get
            {
                return estadomarcacaoid;
            }
            set
            {
                estadomarcacaoid = value;
            }
        }



    }
}