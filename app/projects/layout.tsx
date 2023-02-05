import Link from "next/link";

export default function ProjectsLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const projects = [
    "term-edit.nvim",
    "Raytracing in Unity",
    "lumpime-tracker",
    "catballchard",
    "Project Rocket",
  ];

  const padding = 32;

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "row",
        width: "100vw",
        height: "100vh",
      }}
    >
      <aside
        style={{
          flexGrow: 1,
          paddingTop: padding,
          paddingLeft: padding,
          borderRight: "solid",
          borderWidth: 2,
          borderColor: "grey",
        }}
      >
        {projects.map((project) => {
          const link = project.replaceAll(' ', '-')
          return (
            <>
              <Link
                key={project}
                href={`/projects/${link}`}
                style={{ display: "block", marginBottom: 16 }}
              >
                {project}
              </Link>
            </>
          );
        })}
      </aside>
      <div
        style={{
          flexGrow: 4,
          paddingTop: padding,
          paddingRight: padding,
          paddingLeft: padding,
        }}
      >
        {children}
      </div>
    </div>
  );
}
