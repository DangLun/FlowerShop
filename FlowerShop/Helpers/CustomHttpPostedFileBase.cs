using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace FlowerShop.Helpers
{
    public class CustomHttpPostedFileBase : HttpPostedFileBase
    {
        private Stream stream;
        private string contentType;
        private string fileName;

        public CustomHttpPostedFileBase(Stream stream, string contentType, string fileName)
        {
            this.stream = stream;
            this.contentType = contentType;
            this.fileName = fileName;
        }

        public override int ContentLength
        {
            get { return (int)stream.Length; }
        }

        public override string ContentType
        {
            get { return contentType; }
        }

        public override string FileName
        {
            get { return fileName; }
        }

        public override Stream InputStream
        {
            get { return stream; }
        }
    }
}