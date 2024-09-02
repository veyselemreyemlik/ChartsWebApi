using Microsoft.AspNetCore.Mvc;
using System.Linq;

[Route("api/[controller]")]
[ApiController]
public class MovieStoreController : ControllerBase
{
    private readonly MovieStoreContext _context;

    public MovieStoreController(MovieStoreContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult GetDirectorViews()
    {
        var directorViews = _context.DirectorViewReports.ToList();
        return Ok(directorViews);
    }
}
