using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace WebApiNet5.Models
{
    public class PaginatedList<T> : List<T>
    {
        public int PageIndex { get; set; }
        public int TotalPage { get; set; }
        public PaginatedList(List<T> items, int pageIndex, int totalpage)
        {
            TotalPage = totalpage;
            PageIndex = pageIndex;
            AddRange(items);
        }
        public static PaginatedList<T> Create(IQueryable<T> query, int pageIndex, int pageSize)
        {
            var count = query.Count();
            var totalPage = (int)Math.Ceiling((double)count / pageSize);
            if (pageIndex < 1)
                pageIndex = 1;
            if (pageIndex > totalPage)
                pageIndex = totalPage;
            var items = query.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();
            return new PaginatedList<T>(items, pageIndex, totalPage);
        }
    }
}
